// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quest_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestModel _$QuestModelFromJson(Map<String, dynamic> json) {
  return _QuestModel.fromJson(json);
}

/// @nodoc
mixin _$QuestModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get estimatedDurationMinutes => throw _privateConstructorUsedError;
  List<CheckpointModel> get checkpoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestModelCopyWith<QuestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestModelCopyWith<$Res> {
  factory $QuestModelCopyWith(
          QuestModel value, $Res Function(QuestModel) then) =
      _$QuestModelCopyWithImpl<$Res, QuestModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String summary,
      String imageUrl,
      int estimatedDurationMinutes,
      List<CheckpointModel> checkpoints});
}

/// @nodoc
class _$QuestModelCopyWithImpl<$Res, $Val extends QuestModel>
    implements $QuestModelCopyWith<$Res> {
  _$QuestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? estimatedDurationMinutes = null,
    Object? checkpoints = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      checkpoints: null == checkpoints
          ? _value.checkpoints
          : checkpoints // ignore: cast_nullable_to_non_nullable
              as List<CheckpointModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestModelImplCopyWith<$Res>
    implements $QuestModelCopyWith<$Res> {
  factory _$$QuestModelImplCopyWith(
          _$QuestModelImpl value, $Res Function(_$QuestModelImpl) then) =
      __$$QuestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String summary,
      String imageUrl,
      int estimatedDurationMinutes,
      List<CheckpointModel> checkpoints});
}

/// @nodoc
class __$$QuestModelImplCopyWithImpl<$Res>
    extends _$QuestModelCopyWithImpl<$Res, _$QuestModelImpl>
    implements _$$QuestModelImplCopyWith<$Res> {
  __$$QuestModelImplCopyWithImpl(
      _$QuestModelImpl _value, $Res Function(_$QuestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? summary = null,
    Object? imageUrl = null,
    Object? estimatedDurationMinutes = null,
    Object? checkpoints = null,
  }) {
    return _then(_$QuestModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      checkpoints: null == checkpoints
          ? _value._checkpoints
          : checkpoints // ignore: cast_nullable_to_non_nullable
              as List<CheckpointModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestModelImpl extends _QuestModel {
  const _$QuestModelImpl(
      {required this.id,
      required this.title,
      required this.summary,
      required this.imageUrl,
      required this.estimatedDurationMinutes,
      required final List<CheckpointModel> checkpoints})
      : _checkpoints = checkpoints,
        super._();

  factory _$QuestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String summary;
  @override
  final String imageUrl;
  @override
  final int estimatedDurationMinutes;
  final List<CheckpointModel> _checkpoints;
  @override
  List<CheckpointModel> get checkpoints {
    if (_checkpoints is EqualUnmodifiableListView) return _checkpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checkpoints);
  }

  @override
  String toString() {
    return 'QuestModel(id: $id, title: $title, summary: $summary, imageUrl: $imageUrl, estimatedDurationMinutes: $estimatedDurationMinutes, checkpoints: $checkpoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            const DeepCollectionEquality()
                .equals(other._checkpoints, _checkpoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      summary,
      imageUrl,
      estimatedDurationMinutes,
      const DeepCollectionEquality().hash(_checkpoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestModelImplCopyWith<_$QuestModelImpl> get copyWith =>
      __$$QuestModelImplCopyWithImpl<_$QuestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestModelImplToJson(
      this,
    );
  }
}

abstract class _QuestModel extends QuestModel {
  const factory _QuestModel(
      {required final String id,
      required final String title,
      required final String summary,
      required final String imageUrl,
      required final int estimatedDurationMinutes,
      required final List<CheckpointModel> checkpoints}) = _$QuestModelImpl;
  const _QuestModel._() : super._();

  factory _QuestModel.fromJson(Map<String, dynamic> json) =
      _$QuestModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get summary;
  @override
  String get imageUrl;
  @override
  int get estimatedDurationMinutes;
  @override
  List<CheckpointModel> get checkpoints;
  @override
  @JsonKey(ignore: true)
  _$$QuestModelImplCopyWith<_$QuestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
