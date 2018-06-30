import 'dart:async';

import 'package:flutter/services.dart';

class CustomTts {
  static const MethodChannel _channel =
  const MethodChannel('github.com/blounty-ak/tts');

  static Future<dynamic> isLanguageAvailable (String language) => _channel.invokeMethod('isLanguageAvailable', <String, Object>{
    'language': language});

  static Future<dynamic> setLanguage (String language) => _channel.invokeMethod('setLanguage', <String, Object>{
    'language': language});

  static Future<dynamic> getAvailableLanguages () => _channel.invokeMethod('getAvailableLanguages');

  static void speak (String text) => _channel.invokeMethod('speak', <String, Object>{
    'text': text});
}