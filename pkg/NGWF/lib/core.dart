// @dart=2.9


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
  Map components = {};
  String startlocation;
  Map plugins = {};
  Map directives = {};
  EventEmitter event;
  var router;
  Map P = {};

  NGWFstart({
    List components,
    List plugins,
    List directives,
    var router,
  }) {
    if (components != null) setComponents(components);
    if (plugins != null) setPlugins(plugins);
    if (directives != null) setDirectives(directives);
    if (router != null) setRouter(router);
    event = EventEmitter();
  }

  static create() {
    var ngwf = NGWFstart();
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
    if (directives != null) {
      directives.forEach((element) {
        this.directives[element.runtimeType] = element;
      });
    }
    return this;
  }

  setPlugins(List plugins) {
    if (plugins != null) {
      plugins.forEach((element) {
        this.plugins[element.runtimeType] = element;
      });
    }
    return this;
  }

  setStartLocation(url) {
    startlocation = url;
    return this;
  }

  setRouter(router) {
    this.router = router;
    return this;
  }

  set1stComponent(component1) {
    components['start-conponent'] = component1;
    return this;
  }

  _init() {
    setDirectives(GlobalDirectives());
  }

  Future _init1stcomponent() async {
    if (components['start-component'] != null) {
      var component = components['start-component']();
      component.setPlugins(P);
      await component.setCtx(this).render();
    }
  }

  run() {
    _init();

    document.addEventListener('DOMContentLoaded', (event) {
      window.location.href = startlocation ?? '#/';
    });

    plugins.forEach((_, pl) async {
      var plugin = pl();
      P[plugin.name] = plugin.setCtx(this).install();
    });

    _init1stcomponent().then((_) {
      components.forEach((key, c) async {
        if (key == 'start-component') return;
        var component = c();
        component.setPlugins(P);
        await component.setCtx(this).render();
      });
    }).then((_) {
      if (router != null) {
        router.setCtx(this).init();
        window.addEventListener('popstate', (event) async {
          router.setCtx(this).init();
        });
      }
    });

    event.on('renderpage', (dynamic component) {
      directives.forEach((_, d) {
        var directive = d();
        directive.setCtx(this).install();
      });
    });
  }
}
