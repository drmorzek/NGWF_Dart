import 'package:NGWF/core.dart';

import 'app.styles.dart';
import 'app.template.dart';

import 'layouts/navbar/navbar.component.dart';

class AppComponent extends NGWFComponent {
  AppComponent()
      : super(
            tag: 'app-root',
            template: apptemplate,
            components: [NavbarComponent()],
            styles: appstyles
      );
}

