package com.example.newsdkplugin
import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.mob.resu.reandroidsdk.MRegisterUser
import io.mob.resu.reandroidsdk.ReAndroidSDK
import io.mob.resu.reandroidsdk.ResulticksChannel
import org.json.JSONObject


//import kotlin.coroutines.jvm.internal.CompletedContinuation.context

/** NewsdkpluginPlugin */
class NewsdkpluginPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var resulticksChannel= ResulticksChannel()
    private lateinit var context: Context
    private lateinit var activity: Activity


  override fun onAttachedToEngine( flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "newsdkplugin")
    channel.setMethodCallHandler(this)
      context = flutterPluginBinding.getApplicationContext()
  }

  override fun onMethodCall( call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
      //ReAndroidSDK.getInstance(this).onLocationUpdate(13.0827,80.2707)
    }
    else if(call.method == "pushLocation") {
        var lat:Double? = call.argument("lat")
        var lang:Double? = call.argument("lang")
      if (lat != null) {
        if (lang != null) {
          ReAndroidSDK.getInstance(context).onLocationUpdate(lat,lang)
        }
      }
    }
    else if(call.method == "addNewNotification") {
      var title:String? = call.argument("title")
      var body:String? = call.argument("body")
      if (title != null) {
        if (body != null) {
          ReAndroidSDK.getInstance(context).addNewNotification(title,body,"MainActivity")

        }
      }
    }
    else if(call.method == "onTrackEvent") {
      var content:String? = call.argument("string")
      if (content != null) {
        ReAndroidSDK.getInstance(context).onTrackEvent(content)
      }
    }
    else if(call.method == "deleteNotificationByCampaignId") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).deleteNotificationByCampaignId(cid)
      }
    }
    else if(call.method == "readNotification") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).readNotification(cid)
      }
    }
    else if(call.method == "appConversionTracking") {
        ReAndroidSDK.getInstance(context).appConversionTracking()
    }
    else if(call.method == "formDataCapture") {
      var formData:String? = call.argument("formData")
    val jobj=JSONObject(formData)
      if (formData != null) {
        ReAndroidSDK.getInstance(context).formDataCapture(jobj)
      }
    }
    else if(call.method == "readNotificationCount") {

      result.success(ReAndroidSDK.getInstance(context).readNotificationCount)
    }
    else if(call.method == "updatePushToken") {
        var token: String?=call.argument("token")
      ReAndroidSDK.getInstance(context).updatePushToken(token)
    }
    else if(call.method == "onDeviceUserRegister") {
      val uid:String?=call.argument("uid")
      val name:String?=call.argument("name")
      val age:String?=call.argument("age")
      val email:String?=call.argument("email")
      val phone:String?=call.argument("phone")
      val gender:String?=call.argument("gender")
      val token:String?=call.argument("token")
      val profileUrl:String?=call.argument("profileUrl")
      val dob:String?=call.argument("dob")
      val education:String?=call.argument("education")
      val employed:Boolean?=call.argument("employed")
      val married:Boolean?=call.argument("employed")

      val obj = MRegisterUser()
      obj.userUniqueId=uid
      obj.name=name
      obj.age=age
      obj.email=email
      obj.phone=phone
      obj.gender=gender
      obj.deviceToken=token
      obj.profileUrl=profileUrl
      obj.dob=dob
      obj.education=education
      if (employed != null) {
        obj.isEmployed=employed
      }
      if (married != null) {
        obj.isMarried=married
      }
      ReAndroidSDK.getInstance(context).onDeviceUserRegister(obj)
    }
    else if(call.method == "deepLinkData") {
      ReAndroidSDK.getInstance(context).deepLinkData
    }
    else {
      //
      result.notImplemented()
    }
  }
    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}


