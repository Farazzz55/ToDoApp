import 'package:flutter/material.dart';
import 'package:to_do_list_project/appColors.dart';

class CustomTextFormField extends StatelessWidget{
  String label;
  String? Function(String?)? validator;
  TextEditingController controller=TextEditingController();
  TextInputType keyboardType;
  bool obscureText;
  CustomTextFormField({required this.label,required this.validator,required this.controller
  , this.keyboardType=TextInputType.text,this.obscureText=false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.lightGrey,
              width: 2
            )
          ),
          //lma bagy aktb byfdl nafs el design
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.lightGrey,
                  width: 2
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.red,
                  width: 2
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.red,
                  width: 2
              )
          ),
          label: Text(label),

        ),
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ,


      ),
    );
  }

}