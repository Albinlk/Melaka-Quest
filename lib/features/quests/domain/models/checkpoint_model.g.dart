// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckpointModelImpl _$$CheckpointModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckpointModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 50.0,
      triviaQuestion: json['triviaQuestion'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctOptionIndex: (json['correctOptionIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$CheckpointModelImplToJson(
        _$CheckpointModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radiusMeters': instance.radiusMeters,
      'triviaQuestion': instance.triviaQuestion,
      'options': instance.options,
      'correctOptionIndex': instance.correctOptionIndex,
    };
