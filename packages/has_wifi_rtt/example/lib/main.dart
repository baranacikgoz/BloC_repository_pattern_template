import 'package:flutter/material.dart';
import 'dart:async';

import 'package:has_wifi_rtt/has_wifi_rtt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _hasRttFeature = "Unknown";

  Future<void> setRttStatus() async {
    final bool _answer = await HasWifiRtt.checkRtt();
    setState(() {
      _hasRttFeature = _answer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Has Wifi Rtt Example App'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Has this device have Wi-Fi RTT support?: $_hasRttFeature"),
              ElevatedButton(
                  onPressed: () => setRttStatus(), child: const Text("Check")),
            ],
          ))),
    );
  }
}
