import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/data/meal_model.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.mealModel});
  final MealModel mealModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'meal_details'.tr(),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
      ),
     
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
             
              child: CachedNetworkImage(
                width: size.width,
                height: size.height * 0.28,
                fit: BoxFit.cover,
                imageUrl: mealModel.imageUrl,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/pngs/breakfast.png',
                  width: size.width,
                  height: size.height * 0.28,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 15.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                mealModel.name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.sacondaryColor,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.primaryColor.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/time.svg', width: 20.w),
                  SizedBox(width: 8.w),
                  Text(
                    mealModel.time,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/svg/star.svg', width: 20.w),
                  SizedBox(width: 8.w),
                  Text(
                    mealModel.rate.toString(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  mealModel.description,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
