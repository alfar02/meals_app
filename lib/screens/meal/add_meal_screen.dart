import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/data/db_helper.dart';
import 'package:meals_app/data/meal_model.dart';
import 'package:meals_app/widget/custom_text_field.dart';
// import 'package:path/path.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController descriotionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        surfaceTintColor: AppColor.backgroundColor,
        title: Text(
          'add_meal'.tr(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'meal_name'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: mealController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }
                      if (text.length < 3) {
                        return 'min_3_characters'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    'image_url'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    maxLines: 3,
                    controller: imageUrlController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }

                      if (!RegExp(
                        r'^(http|https):\/\/([\w\-]+\.)+[\w\-]+(\/[\w\-./?%&=]*)?$',
                        caseSensitive: false,
                      ).hasMatch(text)) {
                        return 'please_enter_valid_url'.tr();
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    'rate'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }

                      if (double.tryParse(text) == null) {
                        return 'please_enter_valid_number'.tr();
                      }

                      if (double.parse(text) < 1 || double.parse(text) > 5) {
                        return 'rate_between_1_5'.tr();
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    'time'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: timeController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }

                      if (!RegExp(r'^\d+$').hasMatch(text) &&
                          !RegExp(r'^\d+\s*-\s*\d+$').hasMatch(text)) {
                        return 'please_enter_valid_time'.tr();
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    'calories'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: caloriesController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }
                      if (int.tryParse(text) == null) {
                        return 'please_enter_valid_number'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    'description'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.sacondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    maxLines: 4,
                    controller: descriotionController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'this_field_is_required'.tr();
                      }
                      if (text.length < 10) {
                        return 'description_min_10'.tr();
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: size.width,
                    height: 50.h,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),

                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          MealModel meal = MealModel(
                            name: mealController.text,
                            imageUrl: imageUrlController.text,
                            description: descriotionController.text,
                            calories: double.parse(caloriesController.text),
                            time: timeController.text,
                            rate: double.parse(rateController.text),
                          );
                          //Controller لل  clear دي عشان اعمل  .then((_) هنا هستخدم ال  
                          //future من نوع  function  وخلي بالك انها مش بتشتغل غير مع 
                          databaseHelper.insertMeal(meal).then((_) {
                            mealController.clear();
                            imageUrlController.clear();
                            descriotionController.clear();
                            caloriesController.clear();
                            timeController.clear();
                            rateController.clear();
                          });
                        }
                      },
                      icon: Text('save'.tr()),
                    ),
                  ),
                  
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
