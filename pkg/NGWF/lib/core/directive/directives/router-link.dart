import 'dart:html';

import '../directive-init.dart';

class RouterLinkDirective extends NGWFDirective {
  RouterLinkDirective() : super(name: 'router-link');

  var routerLinkListener = {};

  @override
  func({node, component, arg, name}) {

    void eventToHash(_) {
      if (window.location.hash != '#$arg') {
        window.location.hash = '#$arg';
      }
    }

    if(routerLinkListener[node.hashCode] == null) {
      routerLinkListener[node.hashCode] = node.on['click'].listen(eventToHash);
    }
  }
}
