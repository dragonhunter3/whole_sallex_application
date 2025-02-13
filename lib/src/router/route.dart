import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/introduction_one.dart';
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
}
