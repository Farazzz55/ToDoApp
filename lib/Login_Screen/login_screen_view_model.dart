import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Login_Screen/login_navigator.dart';
import '../firebase_utilz.dart';
import '../provider/auth_user_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      navigator.showMyLoading('Loading..');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        navigator.hideMyLoading();
        navigator.showMyMessage('Login Successful');

        var user = await FirebaseUtilz.readUserFromFirestore(credential.user?.uid ?? '');
        if (user != null) {
          var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
          authProvider.updateUser(user);
        }
      } on FirebaseAuthException catch (e) {
        navigator.hideMyLoading();
        if (e.code == 'invalid-email') {
          navigator.showMyMessage('The email address is not valid.');
        } else if (e.code == 'user-not-found') {
          navigator.showMyMessage('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          navigator.showMyMessage('Wrong password provided for that user.');
        } else {
          navigator.showMyMessage('Login failed. Please try again.');
        }
      } catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage(e.toString());
      }
    }
  }
}
