import 'dart:async';
import 'dart:ffi';

import 'package:flutter/src/widgets/framework.dart';

import 'newsdkplugin_platform_interface.dart';

class Newsdkplugin {
  get myAppState => null;

  Future<String?> getPlatformVersion() {
    return NewsdkpluginPlatform.instance.getPlatformVersion();
  }

  pushLocation(double lat, double lang) {
    NewsdkpluginPlatform.instance.pushLocation(lat, lang);
  }

  addNewNotification(String notificationTitle, String notificationBody) {
    NewsdkpluginPlatform.instance.addNewNotification(
        notificationTitle, notificationBody);
  }
  onTrackEvent(String content) {
    NewsdkpluginPlatform.instance.onTrackEvent(content);
  }

  void deleteNotificationByCampaignId(String cid) {
    NewsdkpluginPlatform.instance.deleteNotificationByCampaignId(cid);
  }
  void readNotification(String cid) {
    NewsdkpluginPlatform.instance.readNotification(cid);
  }
  void appConversionTracking() {
    NewsdkpluginPlatform.instance.appConversionTracking();
  }
  void formDataCapture(String formData) {
    NewsdkpluginPlatform.instance.formDataCapture(formData);
  }
  Future<int?>  readNotificationCount() {
    return NewsdkpluginPlatform.instance.readNotificationCount();
  }
  void updatePushToken(String token) {
    NewsdkpluginPlatform.instance.updatePushToken(token);
  }
  void onDeviceUserRegister(String uid, String name, String age, String email, String phone, String gender, String token, String profileUrl, String dob, String education, bool employed, bool married) {
    NewsdkpluginPlatform.instance.onDeviceUserRegister(uid,name,age,email,phone,gender,token,profileUrl,dob,education,employed,married);
  }
  void deepLinkData () {
    NewsdkpluginPlatform.instance.deepLinkData();
  }
}