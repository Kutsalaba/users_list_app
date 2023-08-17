import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:users_list_app/helper/init_dependencies.dart';
import 'package:users_list_app/pages/home/home_page.dart';
import 'package:users_list_app/styles/app_colors.dart';
import 'package:users_list_app/styles/app_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          color: AppColors.brandywineRaspberryColor,
          initialBinding: InitDependenices(),
          theme: AppThemeData().defaultThemeData,
          home: child,
        );
      },
      child: const HomePage(),
    );
  }
}
