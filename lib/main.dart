import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/config/router_config.dart';
import 'package:untitled/router/app_pages.dart';
import 'package:untitled/router/app_router.dart';
import 'package:untitled/screens/home_screen/home_screen.dart';
import 'package:untitled/screens/login_screen/login_screen.dart';
import 'package:untitled/screens/splash_screen/splash_screen.dart';
import 'package:untitled/utils/constants.dart';
import 'package:untitled/utils/session_storage_helper.dart';

import 'controller/app_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SessionStorageHelper.init();
  await appController.getLoginData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DATN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: kPrimaryColor,
          fontFamily: 'Montserrat',
        ),
      ),
      getPages: RouteConfig().getRoute,
      initialRoute: AppRoutes.DASHBOARD,
    );
  }
}

