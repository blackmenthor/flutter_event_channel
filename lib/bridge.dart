import 'package:flutter/services.dart';

class NativeBridge {

  static const messageChannel = const MethodChannel('com.anggach.flutternativesample/channel');
  static const methodChangeBadmood = "BADMOOD";

  static const eventChannel =
  const EventChannel('com.anggach.flutternativesample/event_channel');

  static bool currentValue = false;
  static Stream<bool> eventStream;

  static Stream<bool> listenToBadmoodChannel() {
    if ( eventStream == null ) eventStream =
        eventChannel.receiveBroadcastStream().cast<bool>();
    return eventStream;
  }

  static void changeBadmood() {
    Map<String, dynamic> params = {};

    currentValue = !currentValue;
    params["badmood"] = currentValue;

    messageChannel.invokeMethod(methodChangeBadmood, params);
  }

}