import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  const MethodChannel channel = MethodChannel('awesome_notifications');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
/*
  test('getPlatformVersion', () async {
    expect(await AwesomeNotifications.platformVersion, '42');
  });
  */
}
