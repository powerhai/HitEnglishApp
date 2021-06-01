

import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

class EventBusService extends GetxService {

  EventBus bus ;
  Future<EventBusService> init() async {
    bus = new EventBus();
    return this;
  }

}