import 'package:NGWF/NGWF/core.dart';

import 'directive.template.dart';

class DirectiveComponent extends NGWFComponent {
  DirectiveComponent() : super(tag:'inputH2');
  setup(){

    template = directivetemplate;
  }
}