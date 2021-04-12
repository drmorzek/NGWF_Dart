import 'package:NGWF/NGWF/core.dart';

import '404.template.dart';

class Page404Component extends NGWFComponent {
  Page404Component() : super(tag:'404');
  setup(){

    template = page404;
  }
}