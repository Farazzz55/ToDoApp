class Task{
  static String collectionName='Task';
  String id;
  String title;
  String Details;
  DateTime dateTime;
  bool isDone;
  Task({this.id='', required this.title , required this.Details,
  required this.dateTime , this.isDone=false});
  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'title':title,
      'Details' : Details,
      'DateTime': dateTime.millisecondsSinceEpoch,
      'isDone' : isDone } ; 
    
    }
    Task.fromFireStore(Map<String,dynamic>Data):this(
      id: Data['id'],
      title: Data['title'],
      Details: Data['Details'],
      dateTime:DateTime.fromMillisecondsSinceEpoch(Data['DateTime']),
      isDone: Data['isDone'],

    );
  } 
