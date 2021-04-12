import 'dart:html';

import '../directive-init.dart';


class RouterLinkDirective extends NGWFDirective {
  RouterLinkDirective() : super(name: 'router-link');
  setup() {
    setFunction((arg, Node node, G) {
      node.on["click"].listen((event) => window.location.href = "#$arg");
      // print(arg);
      // print(node);
      // print(G);
    });
   
  }
}
