import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/providers/game_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Game provider initial values and heart loss', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Initial state
    var profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(5));
    expect(profile.maxHearts, equals(5));
    expect(profile.xp, equals(0));

    // Lose a heart
    container.read(userProfileProvider.notifier).loseHeart();
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(4));

    // Complete lesson gives XP and Gems
    const dummyLesson = Lesson(
      id: 'test_lesson',
      title: 'Test',
      description: 'Test Desc',
      xpReward: 30,
      gemReward: 15,
      questions: [],
    );

    container.read(userProfileProvider.notifier).completeLesson(dummyLesson);
    profile = container.read(userProfileProvider);

    expect(profile.xp, equals(30));
    expect(profile.gems, equals(115)); // 100 + 15
    expect(profile.streak, equals(1));
    expect(profile.completedLessonIds.contains('test_lesson'), isTrue);
  });
}
