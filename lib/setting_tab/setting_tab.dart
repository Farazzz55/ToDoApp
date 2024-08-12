import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_project/appColors.dart';
import 'package:to_do_list_project/provider/app_config_provider.dart';
import 'package:to_do_list_project/setting_tab/theme_bottom_sheet.dart';


class SettingTab extends StatefulWidget {
  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            'Mode',
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleMedium,
                color: provider.appTheme == ThemeMode.light?
                AppColors.Dark : AppColors.white
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: (){
              showThemeBottomSheet();


            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),

              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appTheme==ThemeMode.light?
                    'Light' : 'Dark', // or 'Dark Mode' based on your preference
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleSmall,
                        color: provider.appTheme == ThemeMode.light?
                        AppColors.Dark : AppColors.Dark
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(context: context,
        isDismissible: false,
        builder: (context)=>ThemeBottomSheet()
    );
  }
}
