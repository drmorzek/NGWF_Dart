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
  var _stylesnode;
  Map P = {};
  Map _components = new Map();
  String styles;
  Map pipes;
  Map props = new Map();
  EventEmitter _event;
  _RouteSettings route;

  NGWFComponent(
      {this.template,
      this.tag,
      data,
      components,
      this.name,
      plugins,
      styles,
      directives}) {
    this.route = _RouteSettings();
    this.P = plugins ?? {};
    this._data = data;
    this._event = EventEmitter();
    this.setComponents(components);
    this.setStyles(styles);
  }

  setCtx(ctx) {
    this.G = ctx;
    return this;
  }

  setStyles(styles) {
    this.styles = styles ?? "";
    this._stylesnode = querySelector("style[name='${this.tag}']");
    if (this._stylesnode == null) {
      H
          .node(H.h(
              tag: "style",
              params: {"type": "text/css", "name": tag},
              child: [this.styles]))
          .Append("head");
    }
    return this;
  }

  setName(name) {
    this.name = name;
    return this;
  }

  setTemplate(template) {
    this.template = template;
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
    return this;
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

    H.CleanHtml(this.tag);
    await H.node(this.template).Push(this.tag);

    if (this._components != null) {
      this._components.forEach((_, c) async {
        var component = c();
        component.setCtx(this.G);
        component.setPlugins(this.P);
        await component.render();
      });
    }
    this.G.event.emit('renderpage', this);

    if (this.afterMount != null) await this.afterMount();
    return this.template;
  }

  setPlugins(plugins) {
    this.P = plugins == null ? {...this.P} : {...this.P, ...plugins};
  }

  call() => this;
}

class _NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}

class _RouteSettings {
  Map params;

  _RouteSettings() {}

  go(url) {
    window.location.href = "#$url";
  }
}
