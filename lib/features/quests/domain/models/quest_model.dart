import 'package:freezed_annotation/freezed_annotation.dart';
import 'checkpoint_model.dart';

part 'quest_model.freezed.dart';
part 'quest_model.g.dart';

@freezed
class QuestModel with _$QuestModel {
  const QuestModel._(); // required for custom getters with Freezed

  const factory QuestModel({
    required String id,
    required String title,
    required String summary,
    required String imageUrl,
    required int estimatedDurationMinutes,
    required List<CheckpointModel> checkpoints,
  }) = _QuestModel;

  factory QuestModel.fromJson(Map<String, dynamic> json) =>
      _$QuestModelFromJson(json);

  int get checkpointCount => checkpoints.length;
}
