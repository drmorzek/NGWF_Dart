import 'dart:html';

import '../directive-init.dart';

class RouterLinkDirective extends NGWFDirective {
  RouterLinkDirective() : super(name: 'router-link');
  setup() {
    nodes.forEach((key, value) {
      key.on["click"].listen((event) => window.location.href = "#$value");
    });
  }
}
