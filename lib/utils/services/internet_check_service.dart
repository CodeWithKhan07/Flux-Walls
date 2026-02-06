import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService extends GetxService with WidgetsBindingObserver {
  final isConnected = true.obs;
  late StreamSubscription<InternetStatus> _subscription;

  // Track if the app is in foreground
  bool _isInForeground = true;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this); // Start observing app lifecycle

    _subscription = InternetConnection().onStatusChange.listen((status) {
      // ONLY update and trigger UI changes if the app is in the foreground
      if (_isInForeground) {
        isConnected.value = status == InternetStatus.connected;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Update foreground status
    _isInForeground = state == AppLifecycleState.resumed;

    // Optional: Re-check connection immediately when returning to the app
    if (_isInForeground) {
      checkConnection();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up
    _subscription.cancel();
    super.onClose();
  }

  Future<void> checkConnection() async {
    bool result = await InternetConnection().hasInternetAccess;
    isConnected.value = result;
  }
}
