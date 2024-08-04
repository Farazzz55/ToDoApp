import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';

import '../Create_Account/CustomTextFormField.dart';
import '../appColors.dart';
import '../dialog_utliz.dart';

class LoginScreen extends StatefulWidget{
  @override
  static String routeName='Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey=GlobalKey<FormState>();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.bgLight,
          child: Image.asset('assets/images/background.png',fit: BoxFit.fill, width: double.infinity, height: double.infinity,),
        ),
        Scaffold(
          backgroundColor:Colors.transparent ,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Login',style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.white
              ),
            ),),
            elevation: 0,
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.3,),

                  CustomTextFormField(label: 'Email',
                    controller:emailController ,
                    validator: (text){
                      if (text== null || text.trim().isEmpty){
                        return'Please Enter Valid Email';
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return'Please Write A Correct Email';
                      }
                      return null ;
                    }
                    ,
                    keyboardType: TextInputType.emailAddress,),
                  CustomTextFormField(label: 'Password',
                    controller:passwordController ,
                    validator:(text){
                      if (text== null || text.trim().isEmpty){
                        return'Please Enter Valid Password';
                      }
                      return null ;

                    } ,
                    obscureText:true ,
                    keyboardType: TextInputType.phone ,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  ElevatedButton(onPressed: (){
                    login();
                  }, child: Text('Login',style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.white
                    ) ,
                  ), ) , style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.priamryColor,
                  ),
                  ),
                  TextButton(onPressed: (){}, child: Text('Create New Account',style: TextStyle(
                    color: AppColors.priamryColor
                  ),))

                ],
              ),
            )
          ),
        )
      ],

    );
  }

  void login ()async {
    if(formKey.currentState!.validate()){
      DialogUtliz.showLoading(context: context, messege: 'loading');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        DialogUtliz.hideLoading(context);
        print('Login Success');
      } on FirebaseAuthException catch (e) {
        DialogUtliz.hideLoading(context);
        DialogUtliz.showMessege(context: context, content: e.toString());
        if (e.code == 'user-not-found') {
          DialogUtliz.hideLoading(context);
          DialogUtliz.showMessege(context: context, content: 'No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtliz.hideLoading(context);
          DialogUtliz.showMessege(context: context, content: 'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      }
    }
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}