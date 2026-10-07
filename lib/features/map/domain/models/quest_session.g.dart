// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestSessionImpl _$$QuestSessionImplFromJson(Map<String, dynamic> json) =>
    _$QuestSessionImpl(
      quest: QuestModel.fromJson(json['quest'] as Map<String, dynamic>),
      completedCheckpointIds: (json['completedCheckpointIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentCheckpointIndex:
          (json['currentCheckpointIndex'] as num?)?.toInt() ?? 0,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuestSessionImplToJson(_$QuestSessionImpl instance) =>
    <String, dynamic>{
      'quest': instance.quest,
      'completedCheckpointIds': instance.completedCheckpointIds,
      'currentCheckpointIndex': instance.currentCheckpointIndex,
      'isComplete': instance.isComplete,
    };
