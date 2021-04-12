import 'package:NGWF/NGWF/core.dart';

import 'pages/directive/directive.component.dart';
import 'pages/home/home.component.dart';
import 'pages/input/input.component.dart';
import 'pages/404/404.component.dart';

class AppRouter extends NGWFRouter {
  AppRouter() : super(tag: "router-view",
  routes: {
      "/input": InputComponent(),
      "/directive": DirectiveComponent(),
      "/directive/:id": DirectiveComponent(),
      "**": Page404Component(),
      "/": HomePageComponent(),
    }  
  );
}
