import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkConnectionController extends GetxController {
  final _connectivity = Connectivity();

  ConnectivityResult _status = ConnectivityResult.none;
  ConnectivityResult get status => _status;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      print("Network connectivity changed: $connectivityResult");
      _status = connectivityResult;
      update();
    });
  }
  
  bool isConnectedToInternet() {
    return _status == ConnectivityResult.wifi ||
        _status == ConnectivityResult.ethernet ||
        _status == ConnectivityResult.mobile;
  }
}
