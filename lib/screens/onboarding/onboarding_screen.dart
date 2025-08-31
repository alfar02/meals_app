import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  

  List<String> titles = [
    "save_your_meals_ingredient",
    "use_our_app_the_best_choice",
    "our_app_your_ultimate_choice",
  ];

  List<String> subtitles = [
    "add_your_meals_and_its_ingredients_and_we_will_save_it_for_you",
    "the_best_choice_for_your_kitchen_do_not_hesitate",
    "all_the_best_restaurants_and_their_top_menus_are_ready_for_you",
  ];

  int padgeIndex = 0;
  CarouselSliderController sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    print('------build------');

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pngs/background_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 30.h,
              right: 30.w,
              left: 30.w,
              child: Container(
                height: 400.h,
                width: 311.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(40.r),
                ),

                child: Column(
                  children: [
                    CarouselSlider(
                      carouselController: sliderController,
                      options: CarouselOptions(
                        height: 300.h,
                        disableCenter: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          debugPrint('my padge index: $index');
                          setState(() {
                            padgeIndex = index;
                          });
                        },
                      ),

                      items: List.generate(subtitles.length, (index) {
                        return Column(
                          children: [
                            SizedBox(height: 20.h),

                            Text(
                              titles[index].tr(),
                              style: TextStyle(
                                fontSize: 32.sp,
                                color: AppColor.backgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 20.h),

                            Text(
                              subtitles[index].tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColor.backgroundColor,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 30.h),

                            DotsIndicator(
                              dotsCount: titles.length,
                              position: padgeIndex.toDouble(),
                              onTap: (index) {
                                debugPrint('onTap: $index');
                                sliderController.animateToPage(index);
                              },
                              decorator: DotsDecorator(
                                size: Size(20.w, 8.h),
                                activeSize: Size(20.w, 8.h),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),

                                color: Colors.grey,
                                activeColor: AppColor.backgroundColor,
                              ),
                            ),
                   
                          ],
                        );
                      }),
                    ),

                    padgeIndex != 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              TextButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('isFirstTime', true);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    homeLayout,
                                  );
                                },
                                child: Text(
                                  'skip'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColor.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  sliderController.nextPage();
                                },
                                child: Text(
                                  'next'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColor.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isFirstTime', true);
                              Navigator.pushReplacementNamed(
                                context,
                                homeLayout,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColor.backgroundColor,
                              radius: 25.r,
                              child: Icon(Icons.arrow_forward),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //floatingActionButton: FloatingActionButton(onPressed: changeLanguage),
    );
  }
}
