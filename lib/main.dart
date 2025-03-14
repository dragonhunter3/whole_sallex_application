import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/features/categories/controller/sort_controller.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/brand_controller.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/filter_controller.dart';
import 'package:whole_selle_x_application/src/features/home/controlller/home_controller.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/controller/introduction_provider.dart';
import 'package:whole_selle_x_application/src/features/setting/controller/setting_controller.dart';
import 'package:whole_selle_x_application/src/router/route.dart';
import 'package:whole_selle_x_application/src/theme/them.dart'; // Import your GoRouter config

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IntroductionProvider>(
          create: (_) => IntroductionProvider(),
        ),
        ChangeNotifierProvider<BottomNavProvider>(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider<SettingController>(
          create: (_) => SettingController(),
        ),
        ChangeNotifierProvider<SortProvider>(
          create: (_) => SortProvider(),
        ),
        ChangeNotifierProvider<FilterController>(
          create: (_) => FilterController(),
        ),
        ChangeNotifierProvider<BrandController>(
          create: (_) => BrandController(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.instance.lightTheme(context),
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
      ),
    );
  }
}
