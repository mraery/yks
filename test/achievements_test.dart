import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/providers/game_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Achievements system calculates 20 achievements and supports claiming rewards', () {
    final container = ProviderContainer();
    final achievements = container.read(achievementsProvider);

    expect(achievements.length, 20);
    expect(achievements.any((a) => a.id == 'streak_3'), isTrue);
    expect(achievements.any((a) => a.id == 'lessons_1'), isTrue);
    expect(achievements.any((a) => a.id == 'trophy_1'), isTrue);
    expect(achievements.any((a) => a.id == 'gems_200'), isTrue);

    // Initial state: not completed lessons
    final firstLessonAch = achievements.firstWhere((a) => a.id == 'lessons_1');
    expect(firstLessonAch.isUnlocked, isFalse);

    // Complete 1 lesson with 100%
    const dummyLesson = Lesson(
      id: 'lesson_tr_1',
      title: 'Ders 1',
      description: 'Test',
      xpReward: 30,
      gemReward: 10,
      questions: [],
    );
    container.read(userProfileProvider.notifier).recordLessonAttempt(dummyLesson, 100.0);
    final updatedAch = container.read(achievementsProvider);
    final unlockedFirstLesson = updatedAch.firstWhere((a) => a.id == 'lessons_1');
    expect(unlockedFirstLesson.isUnlocked, isTrue);
    expect(unlockedFirstLesson.isClaimed, isFalse);

    // Claim reward
    final initialGems = container.read(userProfileProvider).gems;
    final initialXp = container.read(userProfileProvider).xp;
    final success = container.read(userProfileProvider.notifier).claimAchievement(
      unlockedFirstLesson.id,
      unlockedFirstLesson.gemReward,
      unlockedFirstLesson.xpReward,
    );

    expect(success, isTrue);
    final userAfterClaim = container.read(userProfileProvider);
    expect(userAfterClaim.gems, initialGems + unlockedFirstLesson.gemReward);
    expect(userAfterClaim.xp, initialXp + unlockedFirstLesson.xpReward);
    expect(userAfterClaim.claimedAchievementIds.contains('lessons_1'), isTrue);

    // Cannot double claim
    final doubleClaim = container.read(userProfileProvider.notifier).claimAchievement(
      unlockedFirstLesson.id,
      unlockedFirstLesson.gemReward,
      unlockedFirstLesson.xpReward,
    );
    expect(doubleClaim, isFalse);
  });
}
