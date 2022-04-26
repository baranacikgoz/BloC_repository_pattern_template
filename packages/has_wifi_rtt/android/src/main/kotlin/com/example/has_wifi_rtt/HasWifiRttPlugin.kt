package com.example.has_wifi_rtt

import android.annotation.TargetApi
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** HasRttFeaturePlugin */
class HasWifiRttPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var packageManager: PackageManager

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "has_wifi_rtt")
    packageManager = flutterPluginBinding.applicationContext.packageManager
    channel.setMethodCallHandler(this)
  }

  @TargetApi(Build.VERSION_CODES.P)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "checkRtt") {
      result.success(packageManager.hasSystemFeature(PackageManager.FEATURE_WIFI_RTT))
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
