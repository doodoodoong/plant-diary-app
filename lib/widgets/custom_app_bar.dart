import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;
  final VoidCallback onHome;

  const CustomAppBar({
    super.key,
    required this.onRefresh,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppConstants.appName),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
          tooltip: '새로고침',
        ),
        IconButton(
          onPressed: onHome,
          icon: const Icon(Icons.home),
          tooltip: '홈으로',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
