import 'dart:html';

import '../../tools/H.dart';
import '../../tools/EventEmitter.dart';
import '../../tools/replaceTMP.dart';
import '../main.dart';

class NGWFComponent {
  dynamic G;
  var template;
  String tag;
  String name;
  Map _data;
  Map P = {};
  Map _components = new Map();
  Map pipes;
  Map props = new Map();
  var router;
  EventEmitter _event;

  NGWFComponent(
      {this.template,
      this.tag,
      data,
      router,
      components,
      this.name,
      plugins,
      directives}) {
    this.P = plugins ?? {};
    this._data = data;
    this._event = EventEmitter();
    this.router = router;
    this.setComponents(components);
  }

  setCtx(ctx) {
    this.G = ctx;
    return this;
  }

  setName(name) {
    this.name = name;
    return this;
  }

  setTemplate(template) {
    this.template = template;
  }

  setRouter(router) {
    this.router = router;
  }

  setTag(tag) {
    this.tag = tag;
  }

  setData(Map data) {
    this._data = data;
  }

  setComponents(List components) {
    if (components != null)
      components.forEach((element) {
        this._components[element.runtimeType] = element;
      });
  }

  setPipes(Map pipes) {
    this.pipes = pipes;
  }

  mount(tag) {
    this.tag = tag;
  }

  emitProps(name, data) {
    this._event.emit("transport-props-between-this-and-${name}", data);
  }

  beforeMount() {}
  setup() {}
  afterMount() {}

  _subscribeProps(name) {
    this._event.on("transport-props-between-this-and-${name}", (data) {
      this.props = data;
      // this.render();
    });
  }

  _init() {
    if (this.name != null) this._subscribeProps(this.name);
    this._subscribeProps(this.runtimeType);
  }

  render() async {
    this._init();

    if (this.beforeMount != null) await this.beforeMount();

    if (this.setup != null) await this.setup();

    this.template = await replaceTMP(
        tmp: this.template, data: this._data, pipe: this.pipes);

    await H.node(this.template).Push(this.tag);

    this.G.event.emit('renderpage', this);

    if (this._components != null) {
      await this._components.forEach((_, c) async {
        var component = c();
        component.setCtx(this.G);
        component.setPlugins(this.P);
        await component.render();
      });
    }

    this.G.components = {...this.G.components, ...this._components};

    if (this.router != null) {
      this.router.setCtx(this.G).init();
      window.addEventListener('popstate', (event) async {
        this.router.setCtx(this.G).init();
      });
    }

    if (this.afterMount != null) await this.afterMount();
    return this.template;
  }

  setPlugins(plugins) {
    this.P = plugins == null ? {...this.P} : {...this.P, ...plugins};
  }

  call() => this;
}
