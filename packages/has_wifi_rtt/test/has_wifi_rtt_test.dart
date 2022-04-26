import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:has_wifi_rtt/has_wifi_rtt.dart';

void main() {
  const MethodChannel channel = MethodChannel('has_wifi_rtt');

  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Returns a Future<bool>', (WidgetTester tester) async {
    expect(HasWifiRtt.checkRtt() is Future<bool>, true);
  });
}
