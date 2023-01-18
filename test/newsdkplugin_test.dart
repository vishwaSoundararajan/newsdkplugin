import 'package:flutter_test/flutter_test.dart';
import 'package:newsdkplugin/newsdkplugin.dart';
import 'package:newsdkplugin/newsdkplugin_platform_interface.dart';
import 'package:newsdkplugin/newsdkplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNewsdkpluginPlatform
    with MockPlatformInterfaceMixin
    implements NewsdkpluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  addNewNotification(String notificationTitle, String notificationBody) {
    // TODO: implement addNewNotification
    throw UnimplementedError();
  }

  @override
  pushLocation(double lat, double lang) {
    // TODO: implement pushLocation
    throw UnimplementedError();
  }
}

void main() {
  final NewsdkpluginPlatform initialPlatform = NewsdkpluginPlatform.instance;

  test('$MethodChannelNewsdkplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNewsdkplugin>());
  });

  test('getPlatformVersion', () async {
    Newsdkplugin newsdkpluginPlugin = Newsdkplugin();
    MockNewsdkpluginPlatform fakePlatform = MockNewsdkpluginPlatform();
    NewsdkpluginPlatform.instance = fakePlatform;

    expect(await newsdkpluginPlugin.getPlatformVersion(), '42');
  });
}
