import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_project/model/task_data_class.dart';

class FirebaseUtilz{
  static CollectionReference<Task> getTaskCollection(){
    return    //withConverer type database
      FirebaseFirestore.instance.collection(Task.collectionName).withConverter<Task>(
          fromFirestore: ((snapshot,options )=> Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task,options)=> task.toFireStore());
  }
  //add task to firebase cloudstore
  static Future<void> addTaskToFireStore(Task task){
        var taskCollectionName = getTaskCollection();
        DocumentReference<Task> taskDocRef=taskCollectionName.doc();
        task.id=taskDocRef.id;
        return taskDocRef.set(task);

  }
  static Future<void> DeleteTaskFromFireStore(Task task){
    var taskColltionName=getTaskCollection();
    return taskColltionName.doc(task.id).delete();
  }
  static Future<void> UpdateTaskDoneInFireStore (Task task){
    var taskColltionName=getTaskCollection();
    return taskColltionName.doc(task.id).update({'isDone':task.isDone});
  }
  static Future<void> UpdateTaskInFireStore(Task task){
    var taskColltionName=getTaskCollection();
    return taskColltionName.doc(task.id).update({
    'title' : task.title ,
      'Details' : task.Details ,
      'DateTime' : task.dateTime ,
     });
  }

}