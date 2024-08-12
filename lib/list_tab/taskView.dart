import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/NewTask/edit_task.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/firebase_utilz.dart';
import 'package:to_do_list_project/list_tab/done_task.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';

import '../model/Task.dart';
import '../provider/auth_user_provider.dart';
import '../provider/list_provider.dart';

class TaskView extends StatefulWidget {
  Task task;
  TaskView({required this.task});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);
    var userProvider= Provider.of<AuthUserProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);


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
                FirebaseUtilz.DeleteTaskFromFireStore(widget.task,userProvider.currentUser!.id!).then((value){
                  print('Task Deleted');
                });
                listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context){
                Navigator.of(context).pushNamed(EditTask.routeName,arguments: widget.task);
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
              color: provider.appTheme == ThemeMode.light?
              AppColors.white : AppColors.Dark,
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
                   Text(widget.task.title ,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   color: AppColors.priamryColor ,
               ),)  ,
                   Text(widget.task.Details, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                     color: provider.appTheme == ThemeMode.light?
                     AppColors.Dark : AppColors.white,
                   ),)
                 ],
               ),
             ),
             IconButton(onPressed: (){
               widget.task.isDone=true;
               FirebaseUtilz.UpdateTaskDoneInFireStore(widget.task,userProvider.currentUser!.id!).timeout(Duration(seconds: 1),onTimeout: (){
                 print('Task Updated');
               });
               listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
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
