import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';

class AppEventBus {
  EventBus _eventBus = EventBus();

  void fireEvent(AppEvent event) {
    _eventBus.fire(event);
  }

  Stream<T> on<T extends AppEvent>() {
    return _eventBus.on<T>();
  }
}

abstract class AppEvent extends Equatable {}
