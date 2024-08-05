import 'package:flutter/foundation.dart';
import 'package:to_do_list_project/model/user.dart';

class AuthUserProvider extends ChangeNotifier{
  myUser ? currentUser;
  void updateUser(myUser newUser){
    currentUser=newUser;
    notifyListeners();
  }

}