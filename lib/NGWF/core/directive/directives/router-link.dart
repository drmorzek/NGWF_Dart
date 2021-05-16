import 'dart:html';

import '../../../core.dart';
import '../directive-init.dart';

class RouterLinkDirective extends NGWFDirective {
  RouterLinkDirective() : super(name: 'router-link');

  var routerLinkListener = {};

  func({node, component, arg, name}) {

    void eventToHash(_) {
      if (window.location.hash != "#$arg") {
        window.location.hash = "#$arg";
      }
    }

    if(this.routerLinkListener[node.hashCode] == null) {
      this.routerLinkListener[node.hashCode] = node.on['click'].listen(eventToHash);
    }
  }
}
