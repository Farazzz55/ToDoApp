import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_project/appColors.dart';

class AddNewTask extends StatefulWidget{
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var formKey=GlobalKey<FormState>();
  var selectedTime=DateTime.now();
 
  @override
  Widget build(BuildContext context) {
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


                ),
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: 'task details',
                      hintStyle: TextStyle(
                          color: AppColors.lightGrey
                      )

                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return("please enter task details");
                    }
                    return null;
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
                      if(formKey.currentState?.validate()==true){
                      }
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
}

