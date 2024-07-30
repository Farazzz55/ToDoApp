import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/list_tab/list_tab.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge,
            color: AppColors.white,
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
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
