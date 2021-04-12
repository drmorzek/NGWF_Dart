import 'dart:html';

import 'package:NGWF/NGWF/core.dart';

import 'directive.template.dart';

class DirectiveComponent extends NGWFComponent {
  DirectiveComponent() : super(tag: 'directive');
  setup() {
    print(route.params);
    template = directivetemplate;
  }
}
