import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/responsive_utils.dart';

class TabletAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;
  final VoidCallback onHome;
  final VoidCallback? onFullScreen;
  final bool isFullScreen;

  const TabletAppBar({
    super.key,
    required this.onRefresh,
    required this.onHome,
    this.onFullScreen,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ResponsiveUtils.isTablet(context);
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.local_florist, size: isTablet ? 28 : 24),
          const SizedBox(width: 12),
          Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: isTablet ? 22 : 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        // 새로고침 버튼
        IconButton(
          onPressed: onRefresh,
          icon: Icon(Icons.refresh, size: isTablet ? 28 : 24),
          tooltip: '새로고침',
          padding: EdgeInsets.all(isTablet ? 12 : 8),
        ),

        // 홈 버튼
        IconButton(
          onPressed: onHome,
          icon: Icon(Icons.home, size: isTablet ? 28 : 24),
          tooltip: '홈으로',
          padding: EdgeInsets.all(isTablet ? 12 : 8),
        ),

        // 풀스크림 버튼(아이패드용)
        if (isTablet && onFullScreen != null)
          IconButton(
            onPressed: onFullScreen,
            icon: Icon(
              isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              size: 28,
            ),
            tooltip: isFullScreen ? '풀스크린 해제' : '풀스크린',
            padding: const EdgeInsets.all(12),
          ),

        const SizedBox(width: 8),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
