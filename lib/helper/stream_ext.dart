import 'dart:async';

extension StreamExtensions<T> on Stream<T> {
  Stream<T> throttle(Duration duration) {
    Timer? throttleTimer;
    StreamController<T> resultStreamController = StreamController<T>();

    listen((event) {
      // here events are ignored if the timer is active
      if (throttleTimer == null || !throttleTimer!.isActive) {
        throttleTimer = Timer(duration, () {});
        resultStreamController.add(event);
      }
    });

    return resultStreamController.stream;
  }
}
