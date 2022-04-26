import 'dart:async';

import 'package:flutter/services.dart';

class HasWifiRtt {
  static const MethodChannel _channel = MethodChannel('has_wifi_rtt');

  /// Returns a Future<bool> which indicates the device has wifi rtt or not.
  static Future<bool> checkRtt() async {
    return await _channel.invokeMethod("checkRtt");
  }
}
