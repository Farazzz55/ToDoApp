import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../appColors.dart';
import '../firebase_utilz.dart';
import '../model/task_data_class.dart';
import '../provider/auth_user_provider.dart';
import '../provider/list_provider.dart';

class DoneTask extends StatelessWidget{
  late Task task;
  DoneTask({required this.task});
  @override
  Widget build(BuildContext context) {
    var listProvider=Provider.of<ListProvider>(context);
    var userProvider= Provider.of<AuthUserProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(

        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context){
                FirebaseUtilz.DeleteTaskFromFireStore(task,userProvider.currentUser!.id!).timeout(Duration(seconds: 1)
                    ,onTimeout:(){
                      print('Task Deleted');
                    });
                listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
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
                  color: AppColors.green,
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
                      color: AppColors.green ,
                    ),)  ,
                    Text(task.Details, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color:  AppColors.green
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text('Done!',style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.green
                ),),
              )

            ],
          ),
        ),
      ),
    );
  }

}