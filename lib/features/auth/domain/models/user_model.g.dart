// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      totalXp: (json['totalXp'] as num?)?.toInt() ?? 0,
      unlockedBadges: (json['unlockedBadges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      completedQuestIds: (json['completedQuestIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'totalXp': instance.totalXp,
      'unlockedBadges': instance.unlockedBadges,
      'completedQuestIds': instance.completedQuestIds,
    };
