import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/storage/cache_helper.dart';
import '../../../features/app/presentation/screens/app_layout.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/holidays/presentation/screens/holidays_screen.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation:
      AppSharedPreferences.sharedPreferences.containsKey(AppStrings.userId)
          ? Routes.appLayout
          : Routes.login,
  redirect: (context, state) {
    // debugPrint("state in app router  ${state.uri}");
    // debugPrint(
    //     "access token in app router  ${AppSharedPreferences.sharedPreferences.containsKey(AppStrings.accessToken)}");
    // if (!AppSharedPreferences.sharedPreferences
    //     .containsKey(AppStrings.accessToken)) {
    //   return Routes.login;
    // }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: Routes.appLayout,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AppLayoutScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
    GoRoute(
      path: Routes.holidays,
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HolidaysScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
    ),
  ],
);
