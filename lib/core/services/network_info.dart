import 'dart:io';

import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final result = await connectivity.checkConnectivity();
      switch (result) {
        case ConnectivityResult.none:
          return false;
        default:
          return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
