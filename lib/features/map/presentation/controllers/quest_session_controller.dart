import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:melaka_quest/features/map/domain/models/quest_session.dart';
import 'package:melaka_quest/features/quests/domain/models/quest_model.dart';
import 'package:melaka_quest/features/quests/domain/models/checkpoint_model.dart';
import 'package:melaka_quest/core/services/persistence_service.dart';
import 'package:melaka_quest/features/auth/data/user_repository.dart';
import 'package:melaka_quest/features/auth/data/auth_repository.dart';
import 'package:melaka_quest/features/profile/presentation/controllers/badge_unlock_controller.dart';

part 'quest_session_controller.g.dart';

@riverpod
class QuestSessionController extends _$QuestSessionController {
  @override
  QuestSession? build() {
    // Attempt to load existing session on initialization
    return PersistenceService.loadSession();
  }

  void startQuest(QuestModel quest) {
    state = QuestSession(quest: quest);
    _save();
  }

  void completeCheckpoint(String checkpointId) {
    final current = state;
    if (current == null) return;

    final updatedCompleted = [...current.completedCheckpointIds, checkpointId];
    final isLast = current.currentCheckpointIndex == current.quest.checkpoints.length - 1;

    state = current.copyWith(
      completedCheckpointIds: updatedCompleted,
      currentCheckpointIndex: isLast ? current.currentCheckpointIndex : current.currentCheckpointIndex + 1,
      isComplete: isLast,
    );
    _save();

    if (isLast) {
      _syncProgress(current.quest.id, current.quest.checkpointCount * 100);
    }
  }

  Future<void> _syncProgress(String questId, int xp) async {
    final authUser = ref.read(authStateProvider).valueOrNull;
    if (authUser != null) {
      final userRepo = ref.read(userRepositoryProvider);
      
      // 1. Sync Quest and XP
      await userRepo.addCompletedQuest(authUser.uid, questId);
      await userRepo.incrementXp(authUser.uid, xp);
      
      // 2. Fetch the updated user profile to check for badges
      final updatedUser = await userRepo.getUserProfile(authUser.uid);
      if (updatedUser != null) {
        final newBadges = ref.read(badgeServiceProvider).checkNewBadges(updatedUser);
        for (final badge in newBadges) {
          await userRepo.addUnlockedBadge(authUser.uid, badge.id);
          // Trigger UI notification
          ref.read(badgeUnlockControllerProvider.notifier).showBadge(badge);
        }
      }
    }
  }

  void clearSession() {
    state = null;
    PersistenceService.clearSession();
  }

  void _save() {
    final current = state;
    if (current != null) {
      PersistenceService.saveSession(current);
    }
  }

  CheckpointModel? get currentCheckpoint {
    final current = state;
    if (current == null || current.isComplete) return null;
    return current.quest.checkpoints[current.currentCheckpointIndex];
  }
}
