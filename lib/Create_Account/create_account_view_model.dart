import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Create_Account/create_account_navigator.dart';
import '../firebase_utilz.dart';
import '../model/user.dart';
import '../provider/auth_user_provider.dart';

class CreateAccountViewModel extends ChangeNotifier{
  late CreateAccountNavigator navigator;
  void register(String email, String password , String userName , BuildContext context)async{
    navigator.showMyLoading('Loading...');
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      myUser myuser= myUser(
          id: credential.user?.uid??' '
          , userName:userName,
          email: email);
      //provider bra el build == > listen
      var authProvider=Provider.of<AuthUserProvider>(context,listen: false);
      authProvider.updateUser(myuser);
      await FirebaseUtilz.addUserToFirebase(myuser);
       // hafdl wa2fa fe el line dh lhad ma yt5zn fe el firestore

      navigator.hideMyLoading();
      navigator.showMessega('Register Successfully');
      print('Register Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideMyLoading();
        navigator.showMessega('The password provided is too weak');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideMyLoading();
        navigator.showMessega('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideMyLoading();
      navigator.showMessega(e.toString());
      print(e);
    }

  }
}