import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {

  NetworkInfo(this.connectivity);
  final Connectivity connectivity;

  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
