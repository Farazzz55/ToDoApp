class myUser {
  static String collectionName='user';
  String ?userName;
  String ?email;
  String ?id;
  myUser({required this.id ,required this.userName , required this.email});

  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'userName' : userName,
      'email' : email
    };
  }
  myUser.fromFireStore(Map<String,dynamic>data):this(
      id: data['id'],
      userName: data['userName'],
      email: data['email']

  );
}