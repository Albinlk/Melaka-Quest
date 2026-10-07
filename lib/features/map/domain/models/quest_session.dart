import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:melaka_quest/features/quests/domain/models/quest_model.dart';

part 'quest_session.freezed.dart';
part 'quest_session.g.dart';

@freezed
class QuestSession with _$QuestSession {
  const factory QuestSession({
    required QuestModel quest,
    @Default([]) List<String> completedCheckpointIds,
    @Default(0) int currentCheckpointIndex,
    @Default(false) bool isComplete,
  }) = _QuestSession;

  factory QuestSession.fromJson(Map<String, dynamic> json) => _$QuestSessionFromJson(json);
}
