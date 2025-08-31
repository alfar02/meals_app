import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/data/db_helper.dart';
import 'package:meals_app/data/meal_model.dart';
import 'package:meals_app/screens/meal/meal_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int padgeIndex = 0;
  CarouselSliderController sliderController = CarouselSliderController();
  List<String> images = [
    'assets/pngs/salad.png',
    'assets/pngs/chicken.png',
    'assets/pngs/Chowmein.png',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'my_meals'.tr(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),

      body: SizedBox(
        width: size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              carouselController: sliderController,
              options: CarouselOptions(
                height: size.height * 0.2,
                disableCenter: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  debugPrint('my padge index: $index');
                  setState(() {
                    padgeIndex = index;
                  });
                },
              ),

              items: List.generate(images.length, (index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      images[index],
                      width: size.width,
                      fit: BoxFit.cover,
                      height: size.height,
                    ),

                    Positioned(
                      bottom: 15.h,
                      child: DotsIndicator(
                        dotsCount: images.length,
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
                          activeColor: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            SizedBox(height: 20.h),
            //My Meals
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Text(
                    "my_meals".tr(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //meals
            Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.instance.getMeals(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text('Is Empty'));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      itemCount: snapshot.data!.length,
                      //scrollDirection: Axis.horizontal,   //scroll direction
                      itemBuilder: (context, index) {
                        MealModel meal = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MealDetailsScreen(mealModel: meal)),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15.w),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: SizedBox(
                                  width: 100.w,
                                  height: 100.h,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: meal.imageUrl,
                                    placeholder: (context, url) => Container(
                                      width: 100.w,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/pngs/breakfast.png',
                                        ),
                                  ),
                                ),
                              ),

                              title: Text(snapshot.data![index].name.tr()),

                              subtitle: Text(
                                '${meal.calories.toString()} calories',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
