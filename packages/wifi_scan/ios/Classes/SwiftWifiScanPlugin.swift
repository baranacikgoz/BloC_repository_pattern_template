import Flutter

// Since no API for scanning or getting scanned results in iOS.
// This class is just a "stub" implementation with sane returns.
// It is maintained to avoid `MissingPluginException`.
public class SwiftWifiScanPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftWifiScanPlugin()
    // set Flutter channels - 1 for method, 1 for event
    let channel = FlutterMethodChannel(
        name: "wifi_scan", binaryMessenger: registrar.messenger()
    )
    registrar.addMethodCallDelegate(instance, channel: channel)
    let eventChannel = FlutterEventChannel(
        name: "wifi_scan/onScannedResultsAvailable",
        binaryMessenger: registrar.messenger()
    )
    eventChannel.setStreamHandler(StubStreamHandler())
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method){
      case "startScan":
          return result(0) // not supported
      case "getScannedResults":
          return result(["error": 0]) // not supported
      default:
          return result(FlutterMethodNotImplemented)
    }
  }
}


class StubStreamHandler: NSObject, FlutterStreamHandler{
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return nil
    }
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
