import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Create_Account/create_account.dart';
import 'package:to_do_list_project/Home_Screen/home_screen.dart';
import 'package:to_do_list_project/Login_Screen/login_navigator.dart';
import 'package:to_do_list_project/Login_Screen/login_screen_view_model.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';
import '../CustomTextFormField.dart';
import '../appColors.dart';
import '../dialog_utliz.dart';

class LoginScreen extends StatefulWidget{
  @override
  static String routeName='Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{
  var formKey=GlobalKey<FormState>();


  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }

  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: provider.appTheme == ThemeMode.light?
            AppColors.bgLight: AppColors.bgDark,
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
                key: viewModel.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.3,),
                      CustomTextFormField(label: 'Email',
                        controller:viewModel.emailController ,
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
                        controller:viewModel.passwordController ,
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
                        viewModel.login(context);
                      }, child: Text('Login',style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.white
                        ) ,
                      ), ) , style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.priamryColor,
                      ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(CreateAccount.routeName);
                      }, child: Text('Create New Account',style: TextStyle(
                          color: AppColors.priamryColor
                      ),))

                    ],
                  ),
                )
            ),
          )
        ],

      ),
    );
  }


  @override
  void hideMyLoading() {
    DialogUtliz.hideLoading(context);
  }

  @override
  void showMyLoading(String message) {
    DialogUtliz.showLoading(context: context, messege: message);
  }

  @override
  void showMyMessage(String message) {
    DialogUtliz.showMessege(context: context, content: message ,ButtonOneName: 'OK' ,
    ButtonOne: (){
      if(message=='Login Successful'){
        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      }else{
        Navigator.pop(context);
      }
    });
  }


}