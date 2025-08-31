import 'package:flutter/material.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:lottie/lottie.dart';
import 'package:meals_app/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      chickOnboarding();
    });
  }

  Future<void> chickOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? false;
    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, homeLayout);
    } else {
      Navigator.pushReplacementNamed(context, onboarding);
    }
  }

  @override
  void dispose() {
    // عشان ال resources
    debugPrint("close splash screen");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Lottie.asset('assets/animations/splash.json')),
    );
  }
}


/*
* Navigator.push هتضيف صفحه في ال stack فوق الصفحه الموجوده
* Navigator.pop هتحذف الصفحه اللي انا فيها من ال stack 
* Navigator.pushReplasment هتحذف الصفحه اللي انا فيها و تضيف الصفحه الجديده
* Navigator.pushReplasment هتحذف الصفحه اللي انا فيها و تضيف الصفحه الجديده
* Navigator.pushAndRemoveUntil  هتحذف كل الصفحات وتضيف اللي عملتلها push بس

? bool => canPop

*/