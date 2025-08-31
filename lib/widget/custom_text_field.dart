import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxLines,
    this.hintText,
    this.maxLength, 
    required this.controller, 
    this.validator, 
    this.keyboardType,
    
  });

  final int? maxLines;
  final String? hintText;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      keyboardType: keyboardType,

      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        //hintText: hintText?.tr(),
        //hintStyle: TextStyle(fontSize: 5.sp, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
          borderRadius: BorderRadius.circular(12.r),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
          borderRadius: BorderRadius.circular(12.r),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
