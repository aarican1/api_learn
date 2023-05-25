import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class INeworkChangeManager {
  Future<NetworkChangeResults> checkFirstTime();
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange);
  void dispose();
}

class NetworkChangeManager extends INeworkChangeManager {
  late final _connectivity;
  StreamSubscription<ConnectivityResult>? subscription;

  NetworkChangeManager() {
    _connectivity = Connectivity();
  }
  @override
  Future<NetworkChangeResults> checkFirstTime() async {
    var connectvityResults = await (_connectivity.checkConnectivity());
    return NetworkChangeResultsExtension.checkResults(connectvityResults);
  }

  @override
  void dispose() {
    subscription?.cancel();
  }

  @override
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange) {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      onChange.call(NetworkChangeResultsExtension.checkResults(event));
    });
  }
}

enum NetworkChangeResults {
  on,
  off,
}

extension NetworkChangeResultsExtension on NetworkChangeResults {
  static NetworkChangeResults checkResults(ConnectivityResult results) {
    switch (results) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.vpn:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.other:
        return NetworkChangeResults.on;

      case ConnectivityResult.none:
      default:
        return NetworkChangeResults.off;
    }
  }
}
