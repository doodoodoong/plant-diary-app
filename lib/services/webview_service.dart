import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/app_constants.dart';

class WebViewService {
  static WebViewController createController({
    required Function(int) onProgress,
    required Function(String) onPageStarted,
    required Function(String) onPageFinished,
    required Function(WebResourceError) onWebResourceError,
  }) {
    late final WebViewController controller;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageStarted: onPageStarted,
          onPageFinished: (String url) {
            onPageFinished(url);
            // 페이지 로드 완료 후 JavaScript 실행
            controller.runJavaScript('''
              const video = document.querySelector('video');
              if (video) {
                // 비디오 요소 제거
                video.remove();
                
                // 배경색 설정 (선택사항)
                document.body.style.backgroundColor = '#1a1a1a';
              }
            ''');
          },
          onWebResourceError: onWebResourceError,
          onNavigationRequest: (NavigationRequest request) {
            // plantdiary.co.kr 내에서만 탐색 허용
            if (request.url.startsWith(AppConstants.baseUrl)) {
              return NavigationDecision.navigate;
            }

            // 외부 링크도 허용
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(AppConstants.homeUrl),
        headers: {
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'Accept-Language': 'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7',
        },
      )
      ..setUserAgent(
        'Mozilla/5.0 (iPad; CPU OS 18_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1',
      );

    return controller;
  }

  static Future<bool> canGoBack(WebViewController controller) async {
    return await controller.canGoBack();
  }

  static Future<void> goBack(WebViewController controller) async {
    if (await canGoBack(controller)) {
      await controller.goBack();
    }
  }

  static Future<void> reload(WebViewController controller) async {
    await controller.reload();
  }

  static Future<void> loadUrl(WebViewController controller, String url) async {
    await controller.loadRequest(Uri.parse(url));
  }
}
