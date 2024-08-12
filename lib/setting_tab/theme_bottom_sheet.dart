import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/appColors.dart';

import '../provider/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget{
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.light);

            },
            child: Text('Light',style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleMedium
            ),),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.dark);

            },
            child: Text('Dark',style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium
            ),),


          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
           ElevatedButton(
               onPressed: () async{
                   await provider.saveSettings();
                   Navigator.pop(context);
               },
               child: Text('Save',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                 color: AppColors.white
               ),),
           style: ElevatedButton.styleFrom(
             backgroundColor: AppColors.Dark
           ),)
        ],
      ),
    );
  }
}