import 'dart:js_interop';

@JS('window.yksAudio.playCorrect')
external void _jsPlayCorrect();

@JS('window.yksAudio.playIncorrect')
external void _jsPlayIncorrect();

@JS('window.yksAudio.playComplete')
external void _jsPlayComplete();

@JS('window.yksAudio.playLessonPass')
external void _jsPlayLessonPass();

@JS('window.yksAudio.playLessonFail')
external void _jsPlayLessonFail();

@JS('window.yksAudio.playFlip')
external void _jsPlayFlip();

void playCorrectSound() {
  try {
    _jsPlayCorrect();
  } catch (_) {}
}

void playIncorrectSound() {
  try {
    _jsPlayIncorrect();
  } catch (_) {}
}

void playCompleteSound() {
  try {
    _jsPlayComplete();
  } catch (_) {}
}

void playLessonPassSound() {
  try {
    _jsPlayLessonPass();
  } catch (_) {}
}

void playLessonFailSound() {
  try {
    _jsPlayLessonFail();
  } catch (_) {}
}

void playFlipSound() {
  try {
    _jsPlayFlip();
  } catch (_) {}
}
