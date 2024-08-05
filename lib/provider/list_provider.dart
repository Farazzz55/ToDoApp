import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../firebase_utilz.dart';
import '../model/task_data_class.dart';

class ListProvider extends ChangeNotifier{
  List<Task>taskList=[];
  DateTime selcetDate = DateTime.now();
  void getAllTasksFromFireStore(String uid)async{
    QuerySnapshot<Task> querySnapshot=await FirebaseUtilz.getTaskCollection(uid).get();
    // List<QueryDocumentSnapshot<Task>
    taskList=querySnapshot.docs.map((doc){
      return doc.data();

    },).toList();
    //filter task based on selectdate
    taskList=taskList.where((task) {
      if(selcetDate.day==task.dateTime.day&&
      selcetDate.month==task.dateTime.month&&
      selcetDate.year==task.dateTime.year){
        return true;
      }
      return false;
    } ,).toList();
    taskList.sort((Task T1, Task T2){
     return  T1.dateTime.compareTo(T2.dateTime);
    });
    notifyListeners();
  }

  void changeSelectDate(DateTime newSelecetDate,String uid){
      selcetDate=newSelecetDate;
      getAllTasksFromFireStore(uid);
      notifyListeners();

  }


}