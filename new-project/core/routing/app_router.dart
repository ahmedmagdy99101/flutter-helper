import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/cache_helper.dart';

import '../constants/storage_constants.dart';
import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation:
      AppSharedPreferences.sharedPreferences.containsKey(
        StorageConstants.userId,
      )
      ? Routes.appLayout
      : Routes.login,
  redirect: (context, state) {
    //! Uncomment the following lines if you want to redirect to login if access token is not present
    // if (!AppSharedPreferences.sharedPreferences
    //     .containsKey(AppStrings.accessToken)) {
    //   return Routes.login;
    // }
    return null;
  },
  routes: [
    // GoRoute(
    //   path: Routes.login,
    //   pageBuilder:
    //       (context, state) => CustomTransitionPage(
    //         key: state.pageKey,
    //         child: const LoginScreen(),
    //         transitionsBuilder: (
    //           context,
    //           animation,
    //           secondaryAnimation,
    //           child,
    //         ) {
    //           return FadeTransition(opacity: animation, child: child);
    //         },
    //       ),
    // ),
    // GoRoute(
    //   path: Routes.appLayout,
    //   pageBuilder:
    //       (context, state) => CustomTransitionPage(
    //         key: state.pageKey,
    //         child: const AppLayoutScreen(),
    //         transitionsBuilder: (
    //           context,
    //           animation,
    //           secondaryAnimation,
    //           child,
    //         ) {
    //           return FadeTransition(opacity: animation, child: child);
    //         },
    //       ),
    // ),
  ],
);
