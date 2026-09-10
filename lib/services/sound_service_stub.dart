import 'package:flutter/services.dart';

const MethodChannel _audioChannel = MethodChannel('com.ykslingo.ykslingo/audio');

void _playOnNative(String method, SystemSoundType fallback) {
  _audioChannel.invokeMethod(method).catchError((_) {
    SystemSound.play(fallback);
  });
}

void playCorrectSound() {
  _playOnNative('playCorrect', SystemSoundType.click);
}

void playIncorrectSound() {
  _playOnNative('playIncorrect', SystemSoundType.alert);
}

void playCompleteSound() {
  playLessonPassSound();
}

void playLessonPassSound() {
  _playOnNative('playLessonPass', SystemSoundType.click);
}

void playLessonFailSound() {
  _playOnNative('playLessonFail', SystemSoundType.alert);
}

void playFlipSound() {
  _playOnNative('playFlip', SystemSoundType.click);
}
