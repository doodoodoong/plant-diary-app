import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/responsive_layout.dart';
import '../services/webview_service.dart';
import '../services/connectivity_service.dart';
import '../constants/app_constants.dart';
import 'tablet_webview_screen.dart';

class WebViewScreen extends StatefulWidget {
  final bool initialConnected;

  const WebViewScreen({super.key, this.initialConnected = true});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final ConnectivityService _connectivityService = ConnectivityService();

  bool _isLoading = true;
  bool _hasError = false;
  String _currentUrl = AppConstants.homeUrl;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    _setupConnectivityListener();
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

  // 폰용 화면
  Widget _buildPhoneLayout() {
    return Scaffold(
      appBar: CustomAppBar(onRefresh: _refresh, onHome: _goHome),
      body: Stack(
        children: [
          if (_hasError)
            ErrorDisplayWidget(onRetry: _retry)
          else
            WebViewWidget(controller: _controller),
          if (_isLoading && !_hasError) const LoadingWidget(),
        ],
      ),
      floatingActionButton: _hasError
          ? null
          : FloatingActionButton(
              onPressed: _goBack,
              tooltip: '뒤로가기',
              child: const Icon(Icons.arrow_back),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      phone: _buildPhoneLayout(),
      tablet: TabletWebViewScreen(initialConnected: widget.initialConnected),
    );
  }
}
