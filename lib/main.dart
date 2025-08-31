import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:meals_app/screens/home_layaut/hame_layout_screen.dart';
import 'package:meals_app/screens/onboarding/onboarding_screen.dart';
import 'package:meals_app/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

/*
  // DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // MealModel meal = MealModel(
  //   name: 'burgar',
  //   imageUrl:
  //       'https://cdn.pixabay.com/photo/2022/08/29/17/44/burger-7419420_1280.jpg',
  //   description:
  //       "A mouth-watering double-patty bacon cheeseburger, layered with fresh lettuce, tomato, onion, and pickles, all nestled within a sesame seed bun.",
  //   calories: 150,
  //   time: '5 - 10',
  //   rate: 3,
  // );
  // MealModel meal2 = MealModel(
  //   name: 'pizza',
  //   imageUrl:
  //       'https://picfiles.alphacoders.com/280/280287.jpg',
  //   description:
  //       "A mouth-watering double-patty bacon cheeseburger, layered with fresh lettuce, tomato, onion, and pickles, all nestled within a sesame seed bun.",
  //   calories: 170,
  //   time: '5 - 10',
  //   rate: 3,
  // );

  // await databaseHelper.database;
  // databaseHelper.insertMeal(meal2);
*/

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            splach: (_) => SplashScreen(),
            onboarding: (_) => OnboardingScreen(),
            homeLayout: (_) => HameLayoutScreen(),
          },
        );
      },
    );
  }
}
