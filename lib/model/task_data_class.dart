class Task{
  static String collectionName='Tasks';
  String id;
  String title;
  String Details;
  DateTime dateTime;
  bool isDone;
  Task({ this.id='' , required this.title
    , required this.Details , required this.dateTime ,  this.isDone=false});

  // ab3t haga llfirebase object==>json
  Map <String,dynamic>toFireStore(){
    return{
      'id' : id,
       'title' : title ,
      'Details' : Details ,
      'DateTime' : dateTime.millisecondsSinceEpoch ,
       'isDone' : isDone

    };
}
Task.fromFireStore(Map<String,dynamic>data):this(
  id: data['id'],
  title: data['title'] ,
  Details:  data['Details'] ,
  dateTime:  DateTime.fromMillisecondsSinceEpoch(data['DateTime']) ,
  isDone: data['isDone']
);

}