library IdGen;

import 'dart:math';

String IdGen({int length = 10}) {
  Random _rnd = Random();
  var _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  var result = String.fromCharCodes(
    Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    ));
  return result;
}
