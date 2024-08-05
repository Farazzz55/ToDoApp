import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/firebase_utilz.dart';
import 'package:to_do_list_project/list_tab/taskView.dart';
import 'package:to_do_list_project/provider/auth_user_provider.dart';
import 'package:to_do_list_project/provider/list_provider.dart';

import '../model/task_data_class.dart';
import 'done_task.dart';

class ListTab extends StatefulWidget{
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late Task task;

  @override
  Widget build(BuildContext context) {
    var listProvider= Provider.of<ListProvider>(context);
    var userProvider= Provider.of<AuthUserProvider>(context);

    if(listProvider.taskList.isEmpty){
    listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: listProvider.selcetDate,
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(selectedDate,userProvider.currentUser!.id!);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDayAsStrMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff5D9CEC),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
              task= listProvider.taskList[index];
             if (task.isDone) {
               return DoneTask(task: task,);
             } else {
               return TaskView(task: task,);
             }
          },
          itemCount:listProvider.taskList.length,),
        )
      ],
    );
  }

}