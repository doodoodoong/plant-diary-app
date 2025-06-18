import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ResponsiveUtils {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getAppPadding(BuildContext context) {
    if (isTablet(context)) {
      double horizontalPadding = AppConstants.tabletSidePadding;
      if (isLandscape(context)) {
        horizontalPadding = AppConstants.tabletSidePadding * 2;
      }
      return EdgeInsets.symmetric(horizontal: horizontalPadding);
    }
    return const EdgeInsets.symmetric(horizontal: 16.0);
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isTablet(context)) {
      return AppConstants.tabletMaxWidth;
    }
    return AppConstants.phoneMaxWidth;
  }

  static double getAppBarHeight(BuildContext context) {
    if (isTablet(context)) {
      return 70.0;
    }
    return kToolbarHeight;
  }
}
