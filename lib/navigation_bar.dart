import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/navigation/app_routes.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/functions.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/history/presentation/history_screen.dart';
import 'package:steps_tracker/features/steps/presentation/steps_screen.dart';
import 'package:steps_tracker/features/weights/presentation/weights_screen.dart';
import 'core/navigation/app_navigation.dart';



class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    StepsScreen(),
    WeightHistoryScreen(),
    StepsHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor(context),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:AppColors.primaryColor(context),
                  radius: 2.4.h,
                  child: SharedPrefService.getUserImage() != null ? Container(
                    width: 2.4.h * 2,
                    height: 2.4.h * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(SharedPrefService.getUserImage()??''),),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) :
                  CustomText16(
                    getUserInitials(SharedPrefService.getUserName()??''),
                  ),
                ),

                4.sw,

                CustomText16(
                  SharedPrefService.getUserName()??'',color: AppColors.backgroundColor(context),
                ),

              ],
            ),

            /// Settings Button
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>NavigationService.pushNamed(AppRoutes.setting),
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        selectedItemColor: AppColors.primaryColor(context),
        backgroundColor: AppColors.whiteColor(context),
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'steps'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'weights'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'history'.tr,
          ),
        ],
      ),
    );
  }


}


