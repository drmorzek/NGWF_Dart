

import 'package:NGWF/core.dart';

var inputH2 = H.div( 
     child: [
    H.br(),
    H.button(id: 'add',
    child: ['Addd']),
    H.hr(),
    H.input(id: "change", params: {
      "ffff": '444'
    }, type: "number"),
    H.hr(),
    H.input(id: "input", child: [
      H.p(classes: ["map"], styles: {"color": "red"}, child: ['пустой текст']),
      H.div(id: "ad", child: []),
    ])
  ]);