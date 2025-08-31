import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meals_app/core/app_color.dart';
import 'package:meals_app/screens/home/home_screen.dart';
import 'package:meals_app/screens/meal/add_meal_screen.dart';
import 'package:meals_app/screens/profile/profile_screen.dart';

class HameLayoutScreen extends StatefulWidget {
  const HameLayoutScreen({super.key});

  @override
  State<HameLayoutScreen> createState() => _HameLayoutScreenState();
}

class _HameLayoutScreenState extends State<HameLayoutScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const AddMealScreen(),
    const ProfileScreen(),
  ];
  int currntIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currntIndex],


      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.backgroundColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.sacondaryColor,
        currentIndex: currntIndex,
        onTap: (index) {
          setState(() {
            currntIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: SvgPicture.asset('assets/svg/home_active.svg'),
            icon: SvgPicture.asset('assets/svg/home.svg'),
          ),
          BottomNavigationBarItem(
            label: 'Add Meal',
            activeIcon: SvgPicture.asset('assets/svg/add_active.svg'),
            icon: SvgPicture.asset('assets/svg/add.svg'),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            activeIcon: SvgPicture.asset('assets/svg/profile_active.svg'),
            icon: SvgPicture.asset('assets/svg/profile.svg'),
          ),
        ],
      ),
    );
  }
}
