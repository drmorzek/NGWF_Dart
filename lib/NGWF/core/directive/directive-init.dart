import 'dart:html';

// this.func(arg, node, this.component, this.G);

class NGWFDirective {
  dynamic G;
  String name;
  var component;
  Map nodes = new Map();

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

  setup() {}

  install() async {
    await querySelectorAll('[${this.name}]').forEach((e) {
      this.nodes[e] = e.attributes[this.name];
    });

    this.setup();

    return this;
  }

  call() => this;
}
