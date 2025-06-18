import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  Stream<List<ConnectivityResult>> get connectivityStream {
    return _connectivity.onConnectivityChanged;
  }

  Future<List<ConnectivityResult>> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  // 단일 ConnectivityResult가 필요한 경우를 위한 헬퍼 메서드
  Future<ConnectivityResult> getFirstConnectivityResult() async {
    final results = await checkConnectivity();
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  }
}
