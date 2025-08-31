import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changeLanguage() {
      if (context.locale == Locale('en')) {
        context.setLocale(Locale('ar'));
      } else {
        context.setLocale(Locale('en'));
      }
    }

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Spacer(flex: 1),

                CircleAvatar(
                  radius: 92.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 90.r,
                    backgroundImage: AssetImage('assets/pngs/profile_page.jpg'),
                  ),
                ),

                SizedBox(height: 10.h),
                Text(
                  'Fares Elfar',
                  style: TextStyle(
                    color: AppColor.sacondaryColor,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Flutter Developer',
                  style: TextStyle(color: Colors.grey[600], fontSize: 20.sp),
                ),

                Spacer(flex: 3),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 250.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      changeLanguage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.sacondaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 15.h,
                      ),
                      elevation: 8.0,
                    ),
                    child: Text(
                      'changeLanguage'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
