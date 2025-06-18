import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget phone;
  final Widget? tablet;
  const ResponsiveLayout({super.key, required this.phone, this.tablet});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isTablet(context) && tablet != null) {
      return tablet!;
    }
    return phone;
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const ResponsiveContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? ResponsiveUtils.getAppPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveUtils.getMaxContentWidth(context),
          ),
          child: child,
        ),
      ),
    );
  }
}
