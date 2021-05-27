// @dart=2.9

import 'package:NGWF/core.dart';

import 'package:NGWFSPA/app/app.component.dart';
import 'package:NGWFSPA/app/app.routes.dart';
import 'package:NGWFSPA/directives/test.dart';
import 'package:NGWFSPA/plugins/test.dart';

void main() {
  
  NGWFstart.create()
    .setComponents([])
    .setRouter(AppRouter())
    .setDirectives([TestDirective()])
    .setPlugins([TestPlugin2()])
    .set1stComponent(AppComponent())
    .run();    
}