// @dart=2.9


import 'dart:html';

// this.func(arg, node, this.component, this.G);

class NGWFDirective {
  dynamic G;
  String name;
  var component;
  Map nodes;

  NGWFDirective({this.name}) {
    nodes = {};
  }

  setName(name) {
    this.name = name;
    return this;
  }

  setComponent(component) {
    this.component = component;
    return this;
  }

  setCtx(ctx) {
    G = ctx;
    return this;
  }

  func({node, component, arg, name}) {}

  install() {
    querySelectorAll('[$name]').forEach((Element e) {
      if (nodes[e] != e.attributes[name]) {
        nodes[e] = e.attributes[name];
      }
      if (func != null) {
        func(
          node: e,
          component: component,
          arg: e.attributes[name],
          name: name,
        );
      }
    });

    // return this;
  }

  call() => this;
}
