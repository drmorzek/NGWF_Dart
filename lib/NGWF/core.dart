export './tools/EventEmitter.dart';
export './tools/H.dart';
export './tools/DOM.dart';
export './tools/IdGenerator.dart';
export './tools/replaceTMP.dart';

export 'core/main.dart';

import 'dart:collection';
import 'dart:html';

import 'core/directive/directives.dart';
import 'tools/EventEmitter.dart';

class NGWFstart {
  Map components = new Map();
  String startlocation;
  Map plugins = new Map();
  Map directives = new Map();
  EventEmitter event;
  var router;
  Map P = new Map();

  NGWFstart({
    List components,
    List plugins,
    List directives,
    router,
  }) {
    if (components != null) this.setComponents(components);
    if (plugins != null) this.setPlugins(plugins);
    if (directives != null) this.setDirectives(directives);
    if (router != null) this.setRouter(router);
    this.event = EventEmitter();
  }

  static create() {
    NGWFstart ngwf = NGWFstart();
    return ngwf;
  }

  setComponents(List components) {
    if (components != null) {
      components.forEach((element) {
        this.components[element.runtimeType] = element;
      });
    }
    return this;
  }

  setDirectives(List directives) {
    if (directives != null)
      directives.forEach((element) {
        this.directives[element.runtimeType] = element;
      });
    return this;
  }

  setPlugins(List plugins) {
    if (plugins != null)
      plugins.forEach((element) {
        this.plugins[element.runtimeType] = element;
      });
    return this;
  }

  setStartLocation(url) {
    this.startlocation = url;
    return this;
  }

  setRouter(router) {
    this.router = router;
    return this;
  }

  set1stComponent(component1) {
    this.components["start-conponent"] = component1;
    return this;
  }

  _init() {
    setDirectives(GlobalDirectives());
  }

  Future _init1stcomponent() async {
    if (this.components["start-component"] != null) {
      var component = this.components["start-component"]();
      component.setPlugins(this.P);
      await component.setCtx(this).render();
    }
  }

  run() {
    this._init();

    document.addEventListener('DOMContentLoaded', (event) {
      window.location.href = this.startlocation ?? "#/";
    });

    this.plugins.forEach((_, pl) async {
      var plugin = pl();
      this.P[plugin.name] = plugin.setCtx(this).install();
    });

    this._init1stcomponent().then((_) {
      this.components.forEach((key, c) async {
        if (key == "start-component") return;
        var component = c();
        component.setPlugins(this.P);
        await component.setCtx(this).render();
      });
    }).then((_) {
      if (this.router != null) {
        this.router.setCtx(this).init();
        window.addEventListener('popstate', (event) async {
          this.router.setCtx(this).init();
        });
      }
    });

    this.event.on('renderpage', (dynamic component) {
      this.directives.forEach((_, d) {
        var directive = d();
        directive.setCtx(this).install();
      });
    });
  }
}
