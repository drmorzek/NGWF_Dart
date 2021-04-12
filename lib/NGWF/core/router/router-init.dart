
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
    var hash = window.location.hash;
    // hashss(hash);
    hash = hash.length != 0 ? hash.substring(1, hash.length) : "#/";

    List routepaths = [
      ...this.routes.keys.toList(),
    ];

    Map params = new Map();
    dynamic check = routepaths
        .where((element) => element != "**")
        .where((path) => _checklocpath("#" + path, window.location.hash));
    

    var routerpath;
    if (check.isNotEmpty) {
      params = await _getParams("#" + check.first, window.location.hash);
      routerpath = check.first;
    } else {
      routerpath = "**";
    }


    if (this.routes[routerpath] != null) {
      var component = this.routes[routerpath]();
      component.route.params = params;
      component.setCtx(this.G);
      component.setTag(this.tag);
      await component.render();
    } else {
      H.CleanHtml(this.tag);
    }
  }
}

var _pathToRegex = (path) {
  var temp = "^" +
      path
          .replaceAll(RegExp(r"\/"), '\\/')
          .replaceAll(RegExp(r":\w+"), "(.+?)") +
      r"$";
  return RegExp(temp);
};

bool _checklocpath(String routepath, String locationpathname) {
  var reg = _pathToRegex(routepath);
  if (!reg.hasMatch(locationpathname)) return false;
  var countroute = routepath.split("/");
  var countlocation = locationpathname.split("/");
  if (countroute.length != countlocation.length) return false;
  return true;
}

var _getParams = (routepath, locationpathname) {
  var reg = _pathToRegex(routepath);
  var matches = reg.firstMatch(locationpathname);
  var list = List<String>.generate(
      matches.groupCount, (index) => matches.group(index + 1));
  var values = list.map((e) => e.split("/")[0]).toList();

  RegExp exp2 = RegExp(r":(\w+)");
  var matches2 = exp2.allMatches(routepath);
  var keys =
      matches2.map((e) => routepath.substring(e.start + 1, e.end)).toList();

  var params = {};
  keys.forEach((e) {
    var i = keys.indexOf(e);
    params[e.toString()] = values[i];
  });
  return params;
};
