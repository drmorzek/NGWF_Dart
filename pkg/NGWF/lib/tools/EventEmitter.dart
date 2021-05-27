// @dart=2.9


library EventEmitter;

typedef RemoveListener = void Function();

abstract class __EventEmitter__ {
  Map<String, List<Function>> events;

  RemoveListener on(String event, Function Function([dynamic data]) handler);

  void once(String event, Function Function([dynamic data]) handler);

  void off(String event);

  void clear();

  void emit(String event, [dynamic data]);
}

class EventEmitter extends __EventEmitter__ {

  final Map<String, List<Function>> _events = {};

  @override
  Map<String, List<Function>> get events => _events;

  EventEmitter();

  @override
  RemoveListener on(String event, Function Function(dynamic data) handler) {
    final List eventContainer = _events.putIfAbsent(event, () => <Function>[]);
    eventContainer.add(handler);
    void offThisListener() {
      eventContainer.remove(handler);
    };
    return offThisListener;
  }

  @override
  void once(String event, void Function(dynamic data) handler) {
    final List eventContainer = _events.putIfAbsent(event, () => <Function>[]);
    eventContainer.add((dynamic data) {
      handler(data);
      off(event);
    });
  }

  @override
  void off(String event) {
    _events.remove(event);
  }

  @override
  void emit(String event, [dynamic data]) {
    final eventContainer = _events[event] ?? [];
    eventContainer.forEach((handler) {
      if (handler is Function) handler(data);
    });
  }

  @override
  void clear() {
    _events.clear();
  }
}