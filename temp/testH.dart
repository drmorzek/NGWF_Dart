import 'dart:convert';
import 'dart:html';

import 'package:NGWF/NGWF/core.dart';

void main() {
  var inputH = '''
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <a class="navbar-item" href="#">
          <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
        </a>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="true" data-target="navbarBasicExample">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div id="navbarBasicExample" class="navbar-end">
        <div class="navbar-start">
          <a class="navbar-item" href="#">
            Home
          </a>

          <a class="navbar-item" href="#">
            Documentation
          </a>

          <a class="navbar-item" href="#">
              More
          </a>
        </div>

        
      </div>
    </nav>

    <inputH2><inputH2/>
  ''';
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

  var node = H.node(inputH).Push('app-root');
  // var node2 = H.node(inputH) ;

  H.node(inputH2).Push('inputH2');

  var i = querySelector("[ffff]");

  // var node2 = node.node.attributes;
  
  
  print(i);


  InputElement inputchange = querySelector("#change");
  InputElement input = querySelector("#input");

  var tmp1 = (text) => H.node(H.h(
      tag: "p",
      classes: ["map"],
      styles: {"color": "white", "background": "red"},
      child: [text]));
  var tmp2 = H.node(H.h(
      tag: "h1",
      classes: ["map"],
      styles: {"color": "red"},
      child: ['всё очистилось нахрен']));

  input.on['input'].listen((event) {
    var text = input.value;
    var index = inputchange.value;
    if (text.length >= 1) {
      tmp1(text).Rewrite('.map', index: index);
    } else {
      tmp2.Rewrite('.map', index: index, all: true);
    }
  });

  // '.map',

  var button = querySelector('#add');
  button.on['click'].listen((event) {
    var text = input.value;

    H
        .node(H.h(tag: "p", classes: [
          "map"
        ], styles: {
          "color": "white",
          "background": "green"
        }, child: [
          text.length >= 1 ? text + " - Новый елемент" : "Новый елемент"
        ]))
        .Append('#ad');
  });

  // doStuff();
}
