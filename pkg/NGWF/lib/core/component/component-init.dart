// @dart=2.9


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
  Map<String, dynamic> _data;
  var _stylesnode;
  Map P = {};
  final Map _components = {};
  String styles;
  Map pipes;
  Map props = {};
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
    route = _RouteSettings();
    P = plugins ?? {};
    _data = data;
    _event = EventEmitter();
    setComponents(components);
    setStyles(styles);
  }

  setCtx(ctx) {
    G = ctx;
    return this;
  }

  setStyles(styles) {
    this.styles = styles ?? '';
    _stylesnode = querySelector("style[name='$tag']");
    if (_stylesnode == null) {
      H
          .node(H.h(
              tag: 'style',
              params: {'type': 'text/css', 'name': tag},
              child: [this.styles]))
          .Append('head');
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

  setData(Map<String, dynamic> data) {
    _data = data;
  }

  setComponents(List components) {
    if (components != null) {
      components.forEach((element) {
        _components[element.runtimeType] = element;
      });
    }
    return this;
  }

  setPipes(Map pipes) {
    this.pipes = pipes;
  }

  mount(tag) {
    this.tag = tag;
  }

  emitProps(name, data) {
    _event.emit('transport-props-between-this-and-$name', data);
  }

  beforeMount() {}
  setup() {}
  afterMount() {}

  _subscribeProps(name) {
    _event.on('transport-props-between-this-and-$name', (data){
      props = data;
      // this.render();
      
    });
  }

  _init() {
    if (name != null) _subscribeProps(name);
    _subscribeProps(runtimeType);
  }

  render() async {
    _init();

    if (beforeMount != null) await beforeMount();

    if (setup != null) await setup();

    template = replaceTMP(tmp: template, data: _data, pipe: pipes);

    H.CleanHtml(tag);
    await H.node(template).Push(tag);

    if (_components != null) {
      _components.forEach((_, c) async {
        var component = c();
        component.setCtx(G);
        component.setPlugins(P);
        await component.render();
      });
    }
    G.event.emit('renderpage', this);

    if (afterMount != null) await afterMount();
    return template;
  }

  setPlugins(plugins) {
    P = plugins == null ? {...P} : {...P, ...plugins};
  }

  call() => this;
}

class _NullTreeSanitizer implements NodeTreeSanitizer {
  @override
  void sanitizeTree(Node node) {}
}

class _RouteSettings {
  Map params;

  _RouteSettings();

  go(url) {
    window.location.href = '#$url';
  }
}
