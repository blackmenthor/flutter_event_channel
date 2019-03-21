package com.anggach.fluttereventchannel

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  private val CHANNEL = "com.anggach.flutternativesample/channel"
  private val METHOD_CHANGE_BADMOOD = "BADMOOD"

  private val EVENT_CHANNEL = "com.anggach.flutternativesample/event_channel"

  private var streamHandler: FlutterStreamHandler? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    setUpMethodChannel()
    setUpEventChannel()
  }

  // EVENT CHANNEL SECTION

  private fun setUpEventChannel() {
    val eventChannel = EventChannel(flutterView, EVENT_CHANNEL)
    this.streamHandler = this.streamHandler
            ?: FlutterStreamHandler()
    eventChannel.setStreamHandler(this.streamHandler)
  }

  // METHOD CHANNEL SECTION

  private fun setUpMethodChannel() {
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler {
      methodCall, result ->
      when(methodCall.method) {
        METHOD_CHANGE_BADMOOD -> changeBadmood(methodCall, result)
        else -> result.notImplemented()
      }
    }
  }

  private fun changeBadmood(methodCall: MethodCall,
                                         result: MethodChannel.Result) {
    val connectivity = methodCall.argument<Boolean>("badmood")

    if (this.streamHandler == null || connectivity == null) return

    val intent = Intent()
    intent.putExtra("badmood", connectivity)
    this.streamHandler?.handleIntent(this, intent)
  }

}
