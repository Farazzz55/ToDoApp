import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/firebase_utilz.dart';

import '../model/task_data_class.dart';
import '../provider/auth_user_provider.dart';
import '../provider/list_provider.dart';

class EditTask extends StatefulWidget {
  static String routeName = 'EditTask_screen';
  @override
  State<EditTask> createState() => _EditTaskState();
}
class _EditTaskState extends State<EditTask> {
  var selectedTime = DateTime.now();
  late TextEditingController titleController;
  late TextEditingController detailsController;
  @override
  Widget build(BuildContext context) {
    var task=ModalRoute.of(context)!.settings.arguments as Task;
    titleController = TextEditingController(text: task.title);
    detailsController = TextEditingController(text: task.Details);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "To Do List",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleLarge,
                color: AppColors.white,
              ),
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          backgroundColor: AppColors.bgLight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 170, horizontal: 25),
          child: Material(
            color: AppColors.white,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: Text('Edit Task', style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 20,
                      ),
                    )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextField(
                    controller: titleController,

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextField(

                    controller: detailsController,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Select Time',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: InkWell(
                      onTap: showDate,
                      child: Text(
                        '${selectedTime.month}/${selectedTime.day}/${selectedTime.year}',
                        style: TextStyle(fontSize: 20, color: AppColors.lightGrey),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        editTask(task);
                      },
                      child: Text(
                        'Save Changes',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.priamryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showDate() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selectedTime = chosenDate;
      });
    }
  }
  void editTask(Task task){
    var listProvider=Provider.of<ListProvider>(context,listen: false);
    var userProvider= Provider.of<AuthUserProvider>(context,listen: false);
    task.title=titleController.text;
    task.Details=detailsController.text;
    task.dateTime=selectedTime;
    FirebaseUtilz.UpdateTaskInFireStore(task,userProvider.currentUser!.id!).timeout(Duration(seconds: 1),onTimeout:
        (){
      print('TaskUpdated');
    });
    listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    Navigator.pop(context);
  }


}
