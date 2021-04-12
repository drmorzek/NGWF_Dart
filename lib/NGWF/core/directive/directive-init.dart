import 'dart:html';

// this.func(arg, node, this.component, this.G);

class NGWFDirective {
  dynamic G;
  String name;
  var component;
  Function func;

  NGWFDirective({this.name, this.func}) {}

  setName(name) {
    this.name = name;
    return this;
  }

  setFunction(func) {
    this.func = func;
    return this;
  }

  setCtx(ctx) {
    this.G = ctx;
    return this;
  }

  setup() {}

  install() {
    this.setup();
      
    querySelectorAll('[${this.name}]').forEach((node) {
      var arg = node.attributes[this.name];
      if (this.func != null) this.func(arg, node, this.G);
    });

    return this;
  }

  call() => this;
}
