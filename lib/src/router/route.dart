import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/bottom_nav.dart';
import 'package:whole_selle_x_application/src/features/auth/forgot_screen.dart';
import 'package:whole_selle_x_application/src/features/auth/signup_screen.dart';
import 'package:whole_selle_x_application/src/features/filters/brands.dart';
import 'package:whole_selle_x_application/src/features/filters/filter_screen.dart';
import 'package:whole_selle_x_application/src/features/categories/item_screen.dart';
import 'package:whole_selle_x_application/src/features/categories/main_catogery.dart';
import 'package:whole_selle_x_application/src/features/categories/search_items.dart';
import 'package:whole_selle_x_application/src/features/home/add_products.dart';
import 'package:whole_selle_x_application/src/features/home/home_page.dart';
import 'package:whole_selle_x_application/src/features/home/user_profile.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/introduction_one.dart';
import 'package:whole_selle_x_application/src/features/auth/login_screen.dart';
import 'package:whole_selle_x_application/src/features/notifications/notifications.dart';
import 'package:whole_selle_x_application/src/router/error_route.dart';
import 'package:whole_selle_x_application/src/router/route_transition.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.introductionPageOne}',
    routes: [
      GoRoute(
        name: AppRoute.introductionPageOne,
        path: '/${AppRoute.introductionPageOne}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const IntroductionOneScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.login,
        path: '/${AppRoute.login}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.signup,
        path: '/${AppRoute.signup}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.forgot,
        path: '/${AppRoute.forgot}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ForgotScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.bottom,
        path: '/${AppRoute.bottom}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BottomNavBar(),
        ),
      ),
      GoRoute(
        name: AppRoute.home,
        path: '/${AppRoute.home}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.products,
        path: '/${AppRoute.products}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: AddProductsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.profile,
        path: '/${AppRoute.profile}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: UserProfileScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.notificationscreen,
        path: '/${AppRoute.notificationscreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: NotificationScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.catogerypage,
        path: '/${AppRoute.catogerypage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: MainCategoryPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.itemsScreen,
        path: '/${AppRoute.itemsScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SearchItems(),
        ),
      ),
      GoRoute(
        name: AppRoute.itempage,
        path: '/${AppRoute.itempage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ItemScreenPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.filterpage,
        path: '/${AppRoute.filterpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: FilterScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.brandpage,
        path: '/${AppRoute.brandpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BrandsScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String introductionPageOne = 'introduction-one';
  static const String login = 'login-screen';
  static const String signup = 'signup-screen';
  static const String forgot = 'forgot-screen';
  static const String bottom = 'bottom-nav';
  static const String home = 'home-page';
  static const String products = 'add-products';
  static const String profile = 'user-profile';
  static const String notificationscreen = 'notifications';
  static const String catogerypage = 'main-catogery';
  static const String itemsScreen = 'search-items';
  static const String itempage = 'item-screen';
  static const String filterpage = 'filter-screen';
  static const String brandpage = 'brands';
}
