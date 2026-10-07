import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkpoint_model.freezed.dart';
part 'checkpoint_model.g.dart';

@freezed
class CheckpointModel with _$CheckpointModel {
  const factory CheckpointModel({
    required String id,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    @Default(50.0) double radiusMeters,
    required String triviaQuestion,
    required List<String> options,
    required int correctOptionIndex,
  }) = _CheckpointModel;

  factory CheckpointModel.fromJson(Map<String, dynamic> json) => _$CheckpointModelFromJson(json);
}
