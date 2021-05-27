// @dart=2.9


library H;

import 'dart:convert';
import 'dart:html';

// element.inHtml(html, treeSanitizer: new _NullTreeSanitizer());
class _NullTreeSanitizer implements NodeTreeSanitizer {
  @override
  void sanitizeTree(Node node) {}
}

class _HmodelParent {
  var _model;
  var _selector;

  get node => _model;
  get selector => _selector;

  _HmodelParent(model) {
    switch (model.runtimeType) {
      case Node:
        _model = model;
        break;
      case String:
        _model = document.createRange().createContextualFragment(model);
        break;
      default:
        throw Exception('$model is not instanse of Node or String');
    }
  }

  _AppendNode(String selector, newnode, {bool clean}) {
    _selector = selector;
    var node = querySelector(_selector);

    var clone = newnode;
    // if (clean) node.remove();
    if (clean) node.innerHtml = '';
    node.append(clone);
    clone.remove();
    return this;
  }

  _RewriteNode(Element node, newnode) {
    final clonenode = newnode.clone(true);
    node.replaceWith(clonenode);
    return this;
  }

  Push(String selector) {
    _selector = selector;
    _AppendNode(selector, _model, clean: true);
    return this;
  }

  Append(String selector) {
    _selector = selector;
    _AppendNode(selector, _model, clean: false);
    return this;
  }

  Rewrite(String selector, {index, bool all}) {
    _selector = selector;

    if (all == null || all == false) {
      var node;
      if (index != null) {
        var id;
        if (index is String) {
          try {
            id = int.parse(index);
          } catch (e) {
            id = 0;
          }
        }
        var nodelist = querySelectorAll(selector);
        if (id > nodelist.length - 1) {
          node = nodelist.last;
        } else {
          node = nodelist[id];
        }
      } else {
        node = querySelector(selector);
      }
      _RewriteNode(node, _model);
    } else {
      RewriteAll(selector);
    }

    return this;
  }

  Clean() {
    querySelector(selector).remove();
    return this;
  }

  Remove() {
    _model.remove();
    return this;
  }

  RewriteAll(String selector) {
    _selector = selector;
    var node = querySelectorAll(_selector);

    node.forEach((element) {
      _RewriteNode(element, _model);
    });
    return this;
  }

  call() => this;
}

class H {
  static CleanHtml(String selector) {
    querySelector(selector).innerHtml = '';
  }

  static RemoveNode(String selector) {
    querySelector(selector)?.remove();
  }

  static _HmodelParent node(model) {
    var h = _HmodelParent(model);
    return h();
  }

  static h(
      {String tag,
      Map params,
      List child,
      Map styles,
      List classes,
      String id}) {
    String _params(Map<dynamic, dynamic> p) {
      var out = '';
      p.forEach((key, value) {
        if (key == 'style' || key == 'class' || key == 'id') return;
        out += ' $key="$value"';
      });
      return out;
    }

    String _styles(Map<dynamic, dynamic> p) {
      var out = ' style="';
      p.forEach((key, value) {
        out += ' $key:$value;';
      });
      return out + '"';
    }

    String _classes(List p) {
      var out = ' class="';
      p.forEach((value) {
        out += ' $value ';
      });
      return out + '"';
    }

    var attr = params != null ? _params(params) : '';
    attr += styles != null ? _styles(styles) : '';
    attr += classes != null ? _classes(classes) : '';
    attr += id != null ? ' id="$id" ' : '';

    var components = '';
    if (child is List) {
      child.forEach((element) {
        components += element;
      });
    }
    ;

    var tpl = StringBuffer("<$tag$attr>$components</$tag>");

    return tpl.toString();
  }

  static div({Map params, List child, Map styles, List classes, String id}) {
    return H.h(
        tag: 'div',
        params: params,
        child: child,
        styles: styles,
        classes: classes,
        id: id);
  }

  static input({
    Map params,
    List child,
    Map styles,
    List classes,
    String id,
    String type = 'text',
    String name = '',
    String value = '',
  }) {
    var newparams = params ?? {};
    newparams['type'] = type;
    newparams['name'] = name;
    newparams['value'] = value;
    return H.h(
        tag: 'input',
        params: newparams,
        child: child,
        styles: styles,
        classes: classes,
        id: id);
  }

  static button({
    Map params,
    List child,
    Map styles,
    List classes,
    String id,
    String type = 'button',
  }) {
    var newparams = params ?? {};
    newparams['type'] = type;
    return H.h(
        tag: 'button',
        params: newparams,
        child: child,
        styles: styles,
        classes: classes,
        id: id);
  }

  static p(
      {Map params,
      List child,
      Map styles,
      List classes,
      String id,
      String type = 'text'}) {
    return H.h(
        tag: 'p',
        params: params,
        child: child,
        styles: styles,
        classes: classes,
        id: id);
  }

  static hr() {
    return H.h(tag: 'hr');
  }

  static br() {
    return H.h(tag: 'br');
  }

  static pre({List child}) {
    return H.h(tag: 'pre', child: child);
  }

  static tag(String tag, List child) {
    return H.h(tag: tag, child: child);
  }

  static span(
      {String text,
      Map params,
      List classes,
      Map styles,
      String id,
      List child}) {
    child = child ?? [];
    if (text != null) child[0] = text;
    return H.h(
        classes: classes,
        params: params,
        styles: styles,
        id: id,
        child: child,
        tag: 'span');
  }
}
