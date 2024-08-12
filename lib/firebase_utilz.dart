import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list_project/model/user.dart';

import 'model/Task.dart';

class FirebaseUtilz{
  static CollectionReference<Task> getTaskCollection(String uid){
    return getUsersCollection().doc(uid).collection(Task.collectionName).withConverter<Task>(
          fromFirestore: ((snapshot,options )=> Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task,options)=> task.toFireStore());
  }
  //add task to firebase cloudstore
  static Future<void> addTaskToFireStore(Task task , String uid){
        var taskCollectionName = getTaskCollection(uid);
        DocumentReference<Task> taskDocRef=taskCollectionName.doc();
        task.id=taskDocRef.id;
        return taskDocRef.set(task);

  }
  static Future<void> DeleteTaskFromFireStore(Task task ,String uid){
    var taskColltionName=getTaskCollection(uid);
    return taskColltionName.doc(task.id).delete();
  }
  static Future<void> UpdateTaskDoneInFireStore (Task task,String uid){
    var taskColltionName=getTaskCollection(uid);
    return taskColltionName.doc(task.id).update({'isDone':task.isDone});
  }
  static Future<void> UpdateTaskInFireStore(Task task,String uid){
    var taskColltionName=getTaskCollection(uid);
    return taskColltionName.doc(task.id).update({
    'title' : task.title ,
      'Details' : task.Details ,
      'DateTime' : task.dateTime.millisecondsSinceEpoch , // edited
     });
  }
   static CollectionReference<myUser> getUsersCollection() {
     return FirebaseFirestore.instance.collection(myUser.collectionName).withConverter<myUser>(
       fromFirestore: (snapshot, options) =>
           myUser.fromFireStore(snapshot.data()!)
       , toFirestore: (myUser, options) => myUser.toFireStore()
     );
   }
   static Future <void>  addUserToFirebase(myUser user){
    return getUsersCollection().doc(user.id).set(user);

   }
   static  Future <myUser?> readUserFromFirestore(String uid) async{
    var querySnapshot= await getUsersCollection().doc(uid).get();
    return querySnapshot.data();

   }
}