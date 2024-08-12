import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/list_tab/taskView.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';
import 'package:to_do_list_project/provider/auth_user_provider.dart';
import 'package:to_do_list_project/provider/list_provider.dart';

import '../appColors.dart';
import '../model/Task.dart';
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
    var provider=Provider.of<AppConfigProvider>(context);

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
          headerProps:  EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle:
            TextStyle(
                color: provider.appTheme == ThemeMode.light?
                AppColors.bgDark : AppColors.white
            ),

            dateFormatter: DateFormatter.fullDateDayAsStrMY(),
          ),
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            todayStyle: DayStyle(
                dayNumStyle: TextStyle(
                    color: provider.appTheme == ThemeMode.light?
                    AppColors.bgDark : AppColors.white
                ),
                dayStrStyle: TextStyle(
                    fontSize: 15,
                    color: provider.appTheme == ThemeMode.light?
                    AppColors.bgDark : AppColors.white
                )

            ),
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                  color: provider.appTheme == ThemeMode.light?
                  AppColors.bgDark : AppColors.white
              ),
              dayStrStyle: TextStyle(
                  fontSize: 15,
                  color: provider.appTheme == ThemeMode.light?
                  AppColors.bgDark : AppColors.white
              )
            ),
            activeDayStyle: DayStyle(
              dayStrStyle: TextStyle(
                fontSize: 15,
                  color: provider.appTheme == ThemeMode.light?
                  AppColors.bgDark : AppColors.white

              ),
              decoration:  BoxDecoration(
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