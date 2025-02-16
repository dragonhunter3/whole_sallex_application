import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/features/auth/forgot_screen.dart';
import 'package:whole_selle_x_application/src/features/auth/signup_screen.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/introduction_one.dart';
import 'package:whole_selle_x_application/src/features/auth/login_screen.dart';
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
}
