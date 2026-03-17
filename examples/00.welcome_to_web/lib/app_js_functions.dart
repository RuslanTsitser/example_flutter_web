import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

/// Показать диалог в браузере
void showBrowserAlert(String message) {
  web.window.alert(message);
}

void openNewWindow(String url) {
  web.window.open(url);
}

@JS('window.alert')
external void alert(JSString message);

@JS('window.confirm')
external JSBoolean confirm(JSString message);

bool showConfirm(String message) {
  final JSString jsMessage = message.toJS;
  final JSBoolean jsResult = confirm(jsMessage);
  final bool result = jsResult.toDart;
  return result;
}

/// Показать confirm в браузере
bool showBrowserConfirm(String message) {
  return web.window.confirm(message);
}

/// Открыть новое окно браузера
void openBrowserWindow(String url) {
  web.window.open(url);
}

/// Печать сообщения в консоль браузера
void consoleLog(String message) {
  web.document.callMethod('console.log'.toJS, message.toJS);
}

void _onChange(web.Event e) {
  consoleLog('onChange: $e');
}

void setCallback() {
  web.window.onfocus = _onChange.toJS;
}

web.HTMLVideoElement? _addedVideo;

void addVideoElement() {
  if (_addedVideo != null) {
    _addedVideo!.remove();
  }
  final video = web.HTMLVideoElement()
    ..src =
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
    ..style.width = '320px'
    ..style.height = '180px'
    ..style.position = 'fixed'
    ..style.right = '16px'
    ..style.bottom = '88px'
    ..style.zIndex = '9999'
    ..style.boxShadow = '0 4px 12px rgba(0,0,0,0.3)'
    ..controls = true
    ..autoplay = true
    ..muted = true;
  web.document.body!.append(video);
  _addedVideo = video;
}

void removeVideoElement() {
  if (_addedVideo != null) {
    _addedVideo!.remove();
    _addedVideo = null;
  }
}

extension type JSPerson._(JSObject _) implements JSObject {
  external JSPerson({JSString? name, JSNumber? age});

  external JSString? get name;
  external JSNumber? get age;
}

@JS()
external JSPerson getPerson();

void printPerson() {
  final JSPerson person = getPerson();
  final String? name = person.name?.toDart;
  final int? age = person.age?.toDartInt;
  print('Name: $name, Age: $age');
}
