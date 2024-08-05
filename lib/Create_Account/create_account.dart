import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Create_Account/CustomTextFormField.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';
import 'package:to_do_list_project/Login_Screen/login_screen.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/dialog_utliz.dart';
import 'package:to_do_list_project/firebase_utilz.dart';
import 'package:to_do_list_project/model/user.dart';
import 'package:to_do_list_project/provider/auth_user_provider.dart';

class CreateAccount extends StatefulWidget{
  static String routeName='CreateAccScreen';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
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
            title: Text('Create Account',style: GoogleFonts.poppins(
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
                  CustomTextFormField(label: 'User Name',
                  controller:nameController ,
                  validator: (text){
                    if (text== null || text.trim().isEmpty){
                      return'Please Enter Valid User Name';
                    } return null ;

                  },),
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
                    } if(text.length<8){
                      return'Password Must Be At Least 8 Characters';
                    }
                    return null ;

                  } ,
                  obscureText:true ,
                  keyboardType: TextInputType.phone ,),
                  CustomTextFormField(label: 'Confirm Password',
                  controller:confirmPasswordController ,
                  validator:(text){
                    if (text== null || text.trim().isEmpty){
                      return'Please Enter Valid Confirm Password';
                    }
                    if(text!=passwordController.text){
                      return"Confirm Password Doesn't Match Password";
                    }
                    return null ;

                  } ,
                  obscureText:true ,
                  keyboardType: TextInputType.phone,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  ElevatedButton(onPressed: (){
                    register ();
                  }, child: Text('Create Account',style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white
                    ) ,
                  ), ) , style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.priamryColor,
                  ),
                  )

                ],
              ),
            ),
          ),
        )
      ],

    );
  }

   void register () async{
    if(formKey.currentState!.validate()){
      DialogUtliz.showLoading(context: context, messege: 'loading');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        myUser myuser= myUser(
            id: credential.user?.uid??' '
            , userName:nameController.text,
            email: emailController.text);
        //provider bra el build == > listen
        var authProvider=Provider.of<AuthUserProvider>(context,listen: false);
        authProvider.updateUser(myuser);
        await FirebaseUtilz.addUserToFirebase(myuser); // hafdl wa2fa fe el line dh lhad ma yt5zn fe el firestore
        DialogUtliz.hideLoading(context);
        DialogUtliz.showMessege(context: context, content: 'Register Successfully',ButtonOneName: 'Ok' ,
        ButtonOne: (){
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }) ;
        print('Register Success');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtliz.hideLoading(context);
          DialogUtliz.showMessege(context: context, content: 'The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtliz.hideLoading(context);
          DialogUtliz.showMessege(context: context, content: 'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtliz.hideLoading(context);
        DialogUtliz.showMessege(context: context, content:e.toString());
        print(e);
      }
    }
  }
}
