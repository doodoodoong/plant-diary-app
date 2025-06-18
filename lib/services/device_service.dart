import 'package:flutter/services.dart';
import 'dart:io';

class DeviceService {
  static final DeviceService _instance = DeviceService._internal();
  factory DeviceService() => _instance;
  DeviceService._internal();

  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;

  // 아이패드에서 상태바 숨기기/보이기
  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  // 화면 방향 설정
  void setPortraitOnly() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void setLandscapeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // 풀스크린 모드
  void enableFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void disableFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
