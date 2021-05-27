import 'dart:html';

import 'package:NGWF/core.dart';

import 'directive.template.dart';

class DirectiveComponent extends NGWFComponent {
  DirectiveComponent() : super(tag: 'directive');
  @override
  setup() {
    template = DirectiveTemplate;
  }
}
