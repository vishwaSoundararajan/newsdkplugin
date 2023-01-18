import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'newsdkplugin_method_channel.dart';

abstract class NewsdkpluginPlatform extends PlatformInterface {
  /// Constructs a NewsdkpluginPlatform.
  NewsdkpluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NewsdkpluginPlatform _instance = MethodChannelNewsdkplugin();

  /// The default instance of [NewsdkpluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNewsdkplugin].
  static NewsdkpluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NewsdkpluginPlatform] when
  /// they register themselves.
  static set instance(NewsdkpluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  pushLocation(double lat,double lang){
    throw UnimplementedError('pushLocation() has not been implemented');
  }
  addNewNotification(String notificationTitle, String notificationBody){
    throw UnimplementedError('newNotification() has not been implemented');
  }

  void onTrackEvent(String content) {
    throw UnimplementedError('onTrackEvent() has not been implemented');
  }

  void deleteNotificationByCampaignId(content) {
    throw UnimplementedError('deleteNotificationByCampaignId() has not been implemented');
  }
  void readNotification(content) {
    throw UnimplementedError('readNotification() has not been implemented');
  }

  void appConversionTracking() {
    throw UnimplementedError('appConversionTracking() has not been implemented');
  }

   void formDataCapture(String formData) {
     throw UnimplementedError('formDataCapture() has not been implemented');
  }

  Future<int?>readNotificationCount() {
    throw UnimplementedError('readNotificationCount() has not been implemented');
  }

  void updatePushToken(String token) {
    throw UnimplementedError('updatePushToken() has not been implemented');
  }

  void onDeviceUserRegister(String uid, String name, String age, String email, String phone, String gender, String token, String profileUrl, String dob, String education, bool employed, bool married) {
    throw UnimplementedError('onDeviceUserRegister() has not been implemented');
  }

  void deepLinkData() {
    throw UnimplementedError('deepLinkData() has not been implemented');
  }
}
