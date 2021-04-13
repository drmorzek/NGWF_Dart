import 'dart:html';

import '../directive-init.dart';

class RouterLinkDirective extends NGWFDirective {
  RouterLinkDirective() : super(name: 'router-link');

  @override
  func({node, component, arg, name, global}) {
    node.on["click"].listen((event) {
        if(window.location.hash != "#$arg") {
          window.location.hash = "#$arg";
        }

    });
  }
}
