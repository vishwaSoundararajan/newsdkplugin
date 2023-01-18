import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:newsdkplugin/newsdkplugin.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller1=TextEditingController();
  String _platformVersion = 'Unknown',token="NULl";
  int notificationCount=0;
  final methodChannel=const MethodChannel("newsdkplugin");
  final _newsdkpluginPlugin = Newsdkplugin();
  late String cid;
  passLocation(){
  double lat=13.0827;
  double lang=  80.2707;
  _newsdkpluginPlugin.pushLocation(lat, lang);
}
  newNotification(){
  var notificationTitle="sample Title";
  var notificationBody="sample BOdy";
    _newsdkpluginPlugin.addNewNotification(notificationTitle,notificationBody);
  }
  ontrackEvent(){
    var content="On Track Event called!!!";
    _newsdkpluginPlugin.onTrackEvent(content);
  }
  deleteNotificationByCampaignid(){
   setCidState();
    _newsdkpluginPlugin.deleteNotificationByCampaignId(cid);
  }
setCidState(){
    setState(() {
    cid=controller1.text;

    });
}
  readnotification(){
   setCidState();
    _newsdkpluginPlugin.readNotification(cid);
  }
  appconversionTracking(){
    _newsdkpluginPlugin.appConversionTracking();
  }
  formdataCapture(){
    Map param = {
    "Name": "vishwa",
    "EmailID": "abc@gmail.com",
    "MobileNo": 9329222922,
    "Gender": "Male",
    "formid": 101, // required
    "apikey": "e37315c0-8578-4bd2-a38a-cbba5dba8110",
      "City":"Chennai"// required
    };
    String formData = jsonEncode(param);
    _newsdkpluginPlugin.formDataCapture(formData);
  }
  updatepushToken(){
    _newsdkpluginPlugin.updatePushToken(token);
  }
  ondeviceRegister(){
    _newsdkpluginPlugin.onDeviceUserRegister('123','vishwa','24','abc@gmail.com','9893839383','Male',token,'www.google.com','2/8/2005','BE',true,false);
  }
  getdeepLinkData() {
    _newsdkpluginPlugin.deepLinkData();
  }
 Future<int?> readnotificationCount() async{
   var nCount=await _newsdkpluginPlugin.readNotificationCount()!;
     setState(()  {
       notificationCount=nCount!;
     });
    if (kDebugMode) {
      print(notificationCount);
    }
    return null;
  }
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((newToken) {
      if (kDebugMode) {
        print("FCM token: ");
      }
      if (kDebugMode) {
        print(newToken);
        setState(() {
          token=newToken!;
        });
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message notification: ${message?.notification?.toMap()} ');
      print('Message data: ${message?.data} ');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _newsdkpluginPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: const BoxConstraints(),
        child:
        Container(
            child: Column(
              children: [
                Center(
                  child: Text('Running on: $_platformVersion\n'),
                ),
            ElevatedButton( onPressed: (){
              passLocation();
            }, child: Text("Push Location"),),
                ElevatedButton( onPressed: (){
                  newNotification();
                }, child: Text("Add New Notification"),),
                ElevatedButton( onPressed: (){
                  ontrackEvent();
                }, child: Text("On Track Event"),),
                TextField(
                  controller: controller1,
                  onTap: (){
                    setState(() {
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter ID",

                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),),
                ElevatedButton( onPressed: (){
                  deleteNotificationByCampaignid();
                }, child: Text("delete Notification By Campaignid"),),
                ElevatedButton( onPressed: (){
                  readnotification();
                }, child: Text("read Notification"),),
                ElevatedButton( onPressed: (){
                  appconversionTracking();
                }, child: Text("app Conversion Tracking"),),
                ElevatedButton( onPressed: (){
                  formdataCapture();
                }, child: Text("form Data Capture"),),
                ElevatedButton( onPressed: (){
                  readnotificationCount();
                }, child: Text("read Notification Count"),),
                ElevatedButton( onPressed: (){
                  updatepushToken();
                }, child: Text("update Push Token"),),
                ElevatedButton( onPressed: (){
                  ondeviceRegister();
                }, child: Text("On Device User Register"),),
                ElevatedButton( onPressed: (){
                  getdeepLinkData();
                }, child: Text("Get deepLinkData"),),
              ],
            ),
          ),
        ),
      ),)
    );
  }


}
