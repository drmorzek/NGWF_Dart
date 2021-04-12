import 'package:NGWF/NGWF/core.dart';

import 'app.routes.dart';
import 'app.template.dart';

import 'layouts/navbar/navbar.component.dart';

class AppComponent extends NGWFComponent {
  AppComponent()
      : super(
            tag: 'app-root',
            template: apptemplate,
            router: AppRouter(),
            components: [NavbarComponent()]);
}
