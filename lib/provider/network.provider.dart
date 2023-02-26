import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityProvider with ChangeNotifier {
  ConnectivityStatus? _status;

  ConnectivityProvider() {
    _status = ConnectivityStatus.offline;
    _init();
  }

  ConnectivityStatus get status => _status!;

  void _init() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _status = ConnectivityStatus.online;
    } else {
      _status = ConnectivityStatus.offline;
    }
    notifyListeners();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _status = ConnectivityStatus.online;
      } else {
        _status = ConnectivityStatus.offline;
      }
      notifyListeners();
    });
  }
}
