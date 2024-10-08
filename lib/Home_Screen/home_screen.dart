import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/Login_Screen/login_screen.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/list_tab/list_tab.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';
import 'package:to_do_list_project/provider/auth_user_provider.dart';
import 'package:to_do_list_project/provider/list_provider.dart';
import 'package:to_do_list_project/setting_tab/setting_tab.dart';

import '../NewTask/add_new_task.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthUserProvider>(context);
    var listProvider=Provider.of<ListProvider>(context);
    var provider=Provider.of<AppConfigProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 1 ? 'Setting' :
          "To Do List\nWelcome ${authProvider.currentUser?.userName ?? " "}!",
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge,
            color: provider.appTheme == ThemeMode.light?
                AppColors.white : AppColors.bgDark
            ,
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        actions: [
          IconButton(onPressed: (){
            listProvider.taskList=[];
            authProvider.currentUser=null;
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalTaskSheet();
        },
        child: Icon(
          Icons.add,
          size: MediaQuery.of(context).size.width * 0.09,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: provider.appTheme == ThemeMode.light?
        AppColors.white : AppColors.Dark,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.01,),
        elevation: 0,
        shape: CircularNotchedRectangle(
        ),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ' '),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ' '),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [ListTab(), SettingTab()];
  void showModalTaskSheet(){
    showModalBottomSheet(context: context, builder:(context) =>
      AddNewTask()
     );
  }
}
