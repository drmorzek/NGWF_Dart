// @dart=2.9


library IdGen;

import 'dart:math';

String IdGen({int length = 10}) {
  var _rnd = Random();
  var _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  var result = String.fromCharCodes(
    Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    ));
  return result;
}
