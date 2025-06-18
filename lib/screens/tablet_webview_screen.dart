import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/tablet_app_bar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/responsive_layout.dart';
import '../services/connectivity_service.dart';
import '../services/webview_service.dart';
import '../services/device_service.dart';
import '../constants/app_constants.dart';
import '../utils/responsive_utils.dart';

class TabletWebViewScreen extends StatefulWidget {
  final bool initialConnected;

  const TabletWebViewScreen({super.key, this.initialConnected = true});

  @override
  _TabletWebViewScreenState createState() => _TabletWebViewScreenState();
}

class _TabletWebViewScreenState extends State<TabletWebViewScreen> {
  late WebViewController _controller;
  final ConnectivityService _connectivityService = ConnectivityService();
  final DeviceService _deviceService = DeviceService();

  bool _isLoading = true;
  bool _hasError = false;
  bool _isFullScreen = false;
  String _currentUrl = AppConstants.homeUrl;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    _setupConnectivityListener();
    _deviceService.setAllOrientations();
  }

  void _initializeWebView() {
    _controller = WebViewService.createController(
      onProgress: _onProgress,
      onPageStarted: _onPageStarted,
      onPageFinished: _onPageFinished,
      onWebResourceError: _onWebResourceError,
    );
  }

  void _setupConnectivityListener() {
    _connectivityService.connectivityStream.listen((results) {
      if (results.contains(ConnectivityResult.none) && !_hasError) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    });
  }

  void _onProgress(int progress) {
    if (progress == 100) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onPageStarted(String url) {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _currentUrl = url;
    });
  }

  void _onPageFinished(String url) {
    setState(() {
      _isLoading = false;
    });
  }

  void _onWebResourceError(WebResourceError error) {
    setState(() {
      _hasError = true;
      _isLoading = false;
    });
  }

  Future<void> _refresh() async {
    await WebViewService.reload(_controller);
  }

  void _goHome() {
    WebViewService.loadUrl(_controller, AppConstants.homeUrl);
  }

  void _retry() {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    _initializeWebView();
  }

  Future<void> _goBack() async {
    await WebViewService.goBack(_controller);
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      _deviceService.enableFullScreen();
    } else {
      _deviceService.disableFullScreen();
    }
  }

  @override
  void dispose() {
    _deviceService.disableFullScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ResponsiveUtils.isTablet(context);
    final bool isLandscape = ResponsiveUtils.isLandscape(context);

    return Scaffold(
      appBar: _isFullScreen
          ? null
          : TabletAppBar(
              onRefresh: _refresh,
              onHome: _goHome,
              onFullScreen: isTablet ? _toggleFullScreen : null,
              isFullScreen: _isFullScreen,
            ),
      body: ResponsiveContainer(
        padding: isTablet && !_isFullScreen
            ? ResponsiveUtils.getAppPadding(context)
            : EdgeInsets.zero,
        child: Stack(
          children: [
            if (_hasError)
              ErrorDisplayWidget(onRetry: _retry)
            else
              Container(
                decoration: isTablet && !_isFullScreen
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      )
                    : null,
                child: ClipRRect(
                  borderRadius: isTablet && !_isFullScreen
                      ? BorderRadius.circular(12)
                      : BorderRadius.zero,
                  child: WebViewWidget(controller: _controller),
                ),
              ),
            if (_isLoading && !_hasError) const LoadingWidget(),
          ],
        ),
      ),
      floatingActionButton: _hasError || _isFullScreen
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 뒤로가기 버튼
                FloatingActionButton(
                  heroTag: 'back',
                  onPressed: _goBack,
                  tooltip: '뒤로가기',
                  child: const Icon(Icons.arrow_back_ios),
                ),
                if (isTablet) ...[
                  const SizedBox(height: 16),
                  // 풀스크린 토글 버튼
                  FloatingActionButton(
                    heroTag: 'fullscreen',
                    onPressed: _toggleFullScreen,
                    mini: true,
                    tooltip: _isFullScreen ? '풀스크린 해제' : '풀스크린',
                    child: Icon(
                      _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    ),
                  ),
                ],
              ],
            ),
      floatingActionButtonLocation: isLandscape
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
