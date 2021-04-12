library DOM;

import 'dart:html';

class DOM {
  DOM();

  static void PushHtml(String selector, String html) {
    _AppendNode(selector, html, clean: true);
  }

  static void AppendHtml(String selector, String html) {
    _AppendNode(selector, html, clean: false);
  }

  static DocumentFragment _AppendNode(String selector, String html,
      {bool clean}) {
    var node = querySelector(selector);
    var clone = document.createRange().createContextualFragment(html);
    if (clean) node.innerHtml = '';
    node.append(clone);
    return clone;
  }

  static void CleanHtml(String selector) {
    querySelector(selector).remove();
  }

  static void RewriteHtml(String selector, String html) {
    Element node = querySelector(selector);
    _RewriteNode(node, html);
  }

  static void _RewriteNode(node, String html) {
    Element parent = node.parentNode;
    var clone = document.createRange().createContextualFragment(html);

    parent.insertBefore(clone, node);
    node.remove();
  }

  static void RewriteAllHtml(String selector, String html) {
    var node = querySelectorAll(selector);
    node.forEach((element) {
      _RewriteNode(element, html);
    });
  }
}
