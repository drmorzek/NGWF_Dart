// import 'dart:collection';
// import 'dart:core';
import 'dart:html';

import '../../core.dart';



class NGWFRouter {
  dynamic G;
  Map routes;
  String tag;

  NGWFRouter({this.tag, this.routes}) {}

  setTag(tag) {
    this.tag = tag;
  }

  setCtx(ctx) {
    this.G = ctx;
    return this;
  }

  setRoutes(routes) {
    this.routes = routes ?? {};
  }

  setup() {}

  init() async {
    await this.setup();

    this.routes.values.forEach((element) {
      this.G.components[element.runtimeType] = element;
    });

    var hash = window.location.hash;
    // hashss(hash);
    hash = hash.length != 0 ? hash.substring(1, hash.length) : "#";

    List keys = [
      ...this.routes.keys.toList(),
    ];

    String key = keys.contains(hash) ? hash : "**";

    if (this.routes[key] != null) {
      var component = this.routes[key]();
      component.setCtx(this.G);
      component.setTag(this.tag);
      await component.render();
    } else {
      H.CleanHtml(this.tag);
    }
  }
}
