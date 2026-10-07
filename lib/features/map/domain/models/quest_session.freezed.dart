// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestSession _$QuestSessionFromJson(Map<String, dynamic> json) {
  return _QuestSession.fromJson(json);
}

/// @nodoc
mixin _$QuestSession {
  QuestModel get quest => throw _privateConstructorUsedError;
  List<String> get completedCheckpointIds => throw _privateConstructorUsedError;
  int get currentCheckpointIndex => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestSessionCopyWith<QuestSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestSessionCopyWith<$Res> {
  factory $QuestSessionCopyWith(
          QuestSession value, $Res Function(QuestSession) then) =
      _$QuestSessionCopyWithImpl<$Res, QuestSession>;
  @useResult
  $Res call(
      {QuestModel quest,
      List<String> completedCheckpointIds,
      int currentCheckpointIndex,
      bool isComplete});

  $QuestModelCopyWith<$Res> get quest;
}

/// @nodoc
class _$QuestSessionCopyWithImpl<$Res, $Val extends QuestSession>
    implements $QuestSessionCopyWith<$Res> {
  _$QuestSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quest = null,
    Object? completedCheckpointIds = null,
    Object? currentCheckpointIndex = null,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      quest: null == quest
          ? _value.quest
          : quest // ignore: cast_nullable_to_non_nullable
              as QuestModel,
      completedCheckpointIds: null == completedCheckpointIds
          ? _value.completedCheckpointIds
          : completedCheckpointIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentCheckpointIndex: null == currentCheckpointIndex
          ? _value.currentCheckpointIndex
          : currentCheckpointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QuestModelCopyWith<$Res> get quest {
    return $QuestModelCopyWith<$Res>(_value.quest, (value) {
      return _then(_value.copyWith(quest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuestSessionImplCopyWith<$Res>
    implements $QuestSessionCopyWith<$Res> {
  factory _$$QuestSessionImplCopyWith(
          _$QuestSessionImpl value, $Res Function(_$QuestSessionImpl) then) =
      __$$QuestSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QuestModel quest,
      List<String> completedCheckpointIds,
      int currentCheckpointIndex,
      bool isComplete});

  @override
  $QuestModelCopyWith<$Res> get quest;
}

/// @nodoc
class __$$QuestSessionImplCopyWithImpl<$Res>
    extends _$QuestSessionCopyWithImpl<$Res, _$QuestSessionImpl>
    implements _$$QuestSessionImplCopyWith<$Res> {
  __$$QuestSessionImplCopyWithImpl(
      _$QuestSessionImpl _value, $Res Function(_$QuestSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quest = null,
    Object? completedCheckpointIds = null,
    Object? currentCheckpointIndex = null,
    Object? isComplete = null,
  }) {
    return _then(_$QuestSessionImpl(
      quest: null == quest
          ? _value.quest
          : quest // ignore: cast_nullable_to_non_nullable
              as QuestModel,
      completedCheckpointIds: null == completedCheckpointIds
          ? _value._completedCheckpointIds
          : completedCheckpointIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentCheckpointIndex: null == currentCheckpointIndex
          ? _value.currentCheckpointIndex
          : currentCheckpointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestSessionImpl implements _QuestSession {
  const _$QuestSessionImpl(
      {required this.quest,
      final List<String> completedCheckpointIds = const [],
      this.currentCheckpointIndex = 0,
      this.isComplete = false})
      : _completedCheckpointIds = completedCheckpointIds;

  factory _$QuestSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestSessionImplFromJson(json);

  @override
  final QuestModel quest;
  final List<String> _completedCheckpointIds;
  @override
  @JsonKey()
  List<String> get completedCheckpointIds {
    if (_completedCheckpointIds is EqualUnmodifiableListView)
      return _completedCheckpointIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedCheckpointIds);
  }

  @override
  @JsonKey()
  final int currentCheckpointIndex;
  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'QuestSession(quest: $quest, completedCheckpointIds: $completedCheckpointIds, currentCheckpointIndex: $currentCheckpointIndex, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestSessionImpl &&
            (identical(other.quest, quest) || other.quest == quest) &&
            const DeepCollectionEquality().equals(
                other._completedCheckpointIds, _completedCheckpointIds) &&
            (identical(other.currentCheckpointIndex, currentCheckpointIndex) ||
                other.currentCheckpointIndex == currentCheckpointIndex) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quest,
      const DeepCollectionEquality().hash(_completedCheckpointIds),
      currentCheckpointIndex,
      isComplete);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestSessionImplCopyWith<_$QuestSessionImpl> get copyWith =>
      __$$QuestSessionImplCopyWithImpl<_$QuestSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestSessionImplToJson(
      this,
    );
  }
}

abstract class _QuestSession implements QuestSession {
  const factory _QuestSession(
      {required final QuestModel quest,
      final List<String> completedCheckpointIds,
      final int currentCheckpointIndex,
      final bool isComplete}) = _$QuestSessionImpl;

  factory _QuestSession.fromJson(Map<String, dynamic> json) =
      _$QuestSessionImpl.fromJson;

  @override
  QuestModel get quest;
  @override
  List<String> get completedCheckpointIds;
  @override
  int get currentCheckpointIndex;
  @override
  bool get isComplete;
  @override
  @JsonKey(ignore: true)
  _$$QuestSessionImplCopyWith<_$QuestSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
