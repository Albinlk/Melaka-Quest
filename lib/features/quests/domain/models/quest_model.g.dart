// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestModelImpl _$$QuestModelImplFromJson(Map<String, dynamic> json) =>
    _$QuestModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      imageUrl: json['imageUrl'] as String,
      estimatedDurationMinutes:
          (json['estimatedDurationMinutes'] as num).toInt(),
      checkpoints: (json['checkpoints'] as List<dynamic>)
          .map((e) => CheckpointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuestModelImplToJson(_$QuestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'imageUrl': instance.imageUrl,
      'estimatedDurationMinutes': instance.estimatedDurationMinutes,
      'checkpoints': instance.checkpoints,
    };
