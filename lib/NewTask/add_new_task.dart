import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/NewTask/edit_task.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/firebase_utilz.dart';

import '../model/Task.dart';
import '../provider/auth_user_provider.dart';
import '../provider/list_provider.dart';

class AddNewTask extends StatefulWidget{
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var formKey=GlobalKey<FormState>();
  String task = '';
  String details = '';
  DateTime selectedTime=DateTime.now();
  late ListProvider listProvider;
  late AuthUserProvider userProvider;


  @override
  Widget build(BuildContext context) {
    listProvider=Provider.of<ListProvider>(context);
    userProvider= Provider.of<AuthUserProvider>(context);

    return  Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.5,
        color: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Add New Task',style: GoogleFonts.poppins(
                    color: AppColors.black,
                    textStyle: Theme.of(context).textTheme.titleMedium
                  ), ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'enter your task',
                    hintStyle: TextStyle(
                      color: AppColors.lightGrey
                    ),
                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return("please enter your task details");
                    }
                    return null;

                  },
                  onChanged: (value) {
                    setState(() {
                      task = value;
                    });
                  },

                ),
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: 'task details',
                      hintStyle: TextStyle(
                          color: AppColors.lightGrey
                      ),


                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return("please enter task details");
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      details = value;
                    });
                  },

                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Text("Select time",style: GoogleFonts.inter(
                  textStyle:TextStyle(
                    fontSize: 20
                  ),
                ), ),
                Center(child: InkWell(
                    onTap: (){
                      showDate();
                    },
                    child: Text('${selectedTime.month}/${selectedTime.day}/${selectedTime.year}',style: TextStyle(fontSize: 20,color: AppColors.lightGrey),))),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.priamryColor,
                    child: IconButton(onPressed: (){
                      addTask();

                    }, icon: Icon(Icons.check , color: AppColors.white,)),
                  ),
                )
              ],
            ),
          ),

           ),
      ),
    );

  }
  void showDate() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedTime=chosenDate?? selectedTime;
    setState(() {

    });
  }
  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task newTask = Task(
        title: task,
        Details: details,
        dateTime: selectedTime,
      );
      FirebaseUtilz.addTaskToFireStore(newTask,userProvider.currentUser!.id!).then((value){
        print('Task Added');
      });
      listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
      Navigator.pop(context);

    }

    listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);

  }

}

