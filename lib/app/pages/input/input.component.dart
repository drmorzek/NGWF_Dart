import 'package:NGWF/core.dart';

import 'input.template.dart';

class InputComponent extends NGWFComponent {
  InputComponent() : super(tag:'app-input');
  @override
  setup(){

    template = inputH2;
  }
}