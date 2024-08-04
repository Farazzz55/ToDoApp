import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/NewTask/edit_task.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/firebase_utilz.dart';
import 'package:to_do_list_project/list_tab/done_task.dart';

import '../model/task_data_class.dart';
import '../provider/list_provider.dart';

class TaskView extends StatelessWidget {
  Task task;
  TaskView({required this.task});


  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),

      child: Slidable(

        startActionPane: ActionPane(
          extentRatio: 0.5,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context){
                FirebaseUtilz.DeleteTaskFromFireStore(task).timeout(Duration(seconds: 1)
                    ,onTimeout:(){
                  print('Task Deleted');
                    });
                listProvider.getAllTasksFromFireStore();
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context){
                Navigator.of(context).pushNamed(EditTask.routeName,
               arguments: task);
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),

          ],
        ),

        child: Container(
          height: MediaQuery.of(context).size.height*0.15,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left:10),
                child: VerticalDivider(
                  color: AppColors.priamryColor,
                  width: MediaQuery.of(context).size.width*0.05,
                  thickness: 8,
                  endIndent: 15,
                  indent: 15,
                ),
              ),
             Expanded(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(task.title ,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   color: AppColors.priamryColor ,
               ),)  ,
                   Text(task.Details, style: Theme.of(context).textTheme.titleSmall,)
                 ],
               ),
             ),
             IconButton(onPressed: (){
               task.isDone=true;
               FirebaseUtilz.UpdateTaskDoneInFireStore(task).timeout(Duration(seconds: 1),onTimeout: (){
                 print('Task Updated');
               });
               listProvider.getAllTasksFromFireStore();
             }, icon: CircleAvatar(
               radius: 25,
               backgroundColor: AppColors.priamryColor,
               child: Icon(Icons.check,color: AppColors.white, size: 40,),
             )),
            ],
          ),
        ),
      ),
    );
  }
}
