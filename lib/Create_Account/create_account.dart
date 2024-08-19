import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Create_Account/create_account_navigator.dart';
import 'package:to_do_list_project/Create_Account/create_account_view_model.dart';
import 'package:to_do_list_project/CustomTextFormField.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/dialog_utliz.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';

class CreateAccount extends StatefulWidget {
  static String routeName='CreateAccScreen';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> implements CreateAccountNavigator{
  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmPasswordController=TextEditingController();

  var formKey=GlobalKey<FormState>();
  CreateAccountViewModel viewModel = CreateAccountViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator= this;
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return ChangeNotifierProvider(
      create: (context){
       viewModel;
      },
      child: Stack(
        children: [
         Container(
           color: provider.appTheme == ThemeMode.light?
           AppColors.bgLight : AppColors.bgDark,
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

      ),
    );
  }

   void register () async{
    if(formKey.currentState!.validate()){
      viewModel.register(emailController.text, passwordController.text ,nameController.text , context );
    }
  }

  @override
  void hideMyLoading() {
    DialogUtliz.hideLoading(context);
  }

  @override
  void showMessega(String message) {
    DialogUtliz.showMessege(context: context, content: message , ButtonOneName: 'OK',
        ButtonOne: (){
          if(message=='Register Successfully'){
            Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
          }else{
            Navigator.pop(context);
          }
    }
    );
  }

  @override
  void showMyLoading(String message) {
    DialogUtliz.showLoading(context: context, messege: message);
  }
}
