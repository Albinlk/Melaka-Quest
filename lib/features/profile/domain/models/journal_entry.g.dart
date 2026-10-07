// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JournalEntryImpl _$$JournalEntryImplFromJson(Map<String, dynamic> json) =>
    _$JournalEntryImpl(
      id: json['id'] as String,
      questId: json['questId'] as String,
      questTitle: json['questTitle'] as String,
      imageUrl: json['imageUrl'] as String,
      note: json['note'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$JournalEntryImplToJson(_$JournalEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questId': instance.questId,
      'questTitle': instance.questTitle,
      'imageUrl': instance.imageUrl,
      'note': instance.note,
      'timestamp': instance.timestamp.toIso8601String(),
    };
