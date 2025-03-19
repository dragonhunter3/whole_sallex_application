import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/features/categories/controller/sort_controller.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkout_controller.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/brand_controller.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/filter_controller.dart';
import 'package:whole_selle_x_application/src/features/home/controlller/home_controller.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/controller/introduction_provider.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/select_color_controller.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/controller.dart/checking_controller.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/controller.dart/rating_controller.dart';
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
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(),
        ),
        ChangeNotifierProvider<SelectedItemProvider>(
          create: (_) => SelectedItemProvider(),
        ),
        ChangeNotifierProvider<SelectedColorProvider>(
          create: (_) => SelectedColorProvider(),
        ),
        ChangeNotifierProvider<CheckingController>(
          create: (_) => CheckingController(),
        ),
        ChangeNotifierProvider<RatingProvider>(
          create: (_) => RatingProvider(),
        ),
        ChangeNotifierProvider<CheckoutController>(
          create: (_) => CheckoutController(),
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
