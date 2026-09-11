import 'sound_service_stub.dart'
    if (dart.library.js_interop) 'sound_service_web.dart' as impl;

class SoundService {
  static int _lastCorrectTime = 0;
  static int _lastIncorrectTime = 0;

  static void playCorrect() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastCorrectTime < 120) return;
    _lastCorrectTime = now;
    impl.playCorrectSound();
  }

  static void playIncorrect() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastIncorrectTime < 120) return;
    _lastIncorrectTime = now;
    impl.playIncorrectSound();
  }

  static int _lastPassTime = 0;
  static int _lastFailTime = 0;

  static void playLessonPass() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastPassTime < 300) return;
    _lastPassTime = now;
    impl.playLessonPassSound();
  }

  static void playLessonFail() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastFailTime < 300) return;
    _lastFailTime = now;
    impl.playLessonFailSound();
  }

  static void playComplete() {
    playLessonPass();
  }

  static void playFlip() {
    impl.playFlipSound();
  }
}
