library EventEmitter;

typedef void RemoveListener();

abstract class __EventEmitter__ {
  Map<String, List<Function>> events;

  RemoveListener on(String event, Function handler([dynamic data]));

  void once(String event, Function handler([dynamic data]));

  void off(String event);

  void clear();

  void emit(String event, [dynamic data]);
}

class EventEmitter extends __EventEmitter__ {

  Map<String, List<Function>> _events = new Map();

  @override
  Map<String, List<Function>> get events => _events;

  EventEmitter() {
  }

  RemoveListener on(String event, Function handler(dynamic data)) {
    final List eventContainer = _events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add(handler);
    void offThisListener() {
      eventContainer.remove(handler);
    };
    return offThisListener;
  }

  void once(String event, void handler(dynamic data)) {
    final List eventContainer = _events.putIfAbsent(event, () => new List<Function>());
    eventContainer.add((dynamic data) {
      handler(data);
      this.off(event);
    });
  }

  void off(String event) {
    _events.remove(event);
  }

  void emit(String event, [dynamic data]) {
    final List eventContainer = _events[event] ?? [];
    eventContainer.forEach((handler) {
      if (handler is Function) handler(data);
    });
  }

  @override
  void clear() {
    _events.clear();
  }
}