

import 'package:NGWF/NGWF/core.dart';

import 'app/app.component.dart';
import 'directives/test.dart';
import 'plugins/test.dart';

void main() {
  
  NGWFstart.create()
    .setComponents([])
    .setDirectives([TestDirective()])
    .setPlugins([TestPlugin2()])
    .set1stComponent(AppComponent())
    .run();
    
}
