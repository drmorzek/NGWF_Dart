import 'dart:html';

// this.func(arg, node, this.component, this.G);

class NGWFDirective {
  dynamic G;
  String name;
  var component;
  Map nodes;

  NGWFDirective({this.name}) {
    this.nodes = {};
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
    this.G = ctx;
    return this;
  }

  func({node, component, arg, name}) {}

  install() {
    querySelectorAll('[${this.name}]').forEach((Element e) {
      if (this.nodes[e] != e.attributes[this.name])
        this.nodes[e] = e.attributes[this.name];
      if (this.func != null) {
        this.func(
          node: e,
          component: this.component,
          arg: e.attributes[this.name],
          name: this.name,
        );
      }
    });

    // return this;
  }

  call() => this;
}
