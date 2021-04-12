import 'package:NGWF/tools/EventEmitter.dart';

void main(List<String> args) {
  EventEmitter event = new EventEmitter();
    
    Function cancelSayHello = event.on('greet', (dynamic name) {
      print('hello ${name}');
    });
    
    Function cancelSayHi = event.on('greet', (dynamic name) {
      print('hi ${name}');
    });
    
    event.emit('greet', 'Axetroy');
    // hello Axetroy
    // hi Axetroy
    
    cancelSayHello();   // remove this listener
    
    event.emit('greet', 'Axetroy');
    // hi Axetroy
    
    event.off('greet');
    
    event.emit('greet', 'Axetroy');
}