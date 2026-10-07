// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkpoint_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckpointModel _$CheckpointModelFromJson(Map<String, dynamic> json) {
  return _CheckpointModel.fromJson(json);
}

/// @nodoc
mixin _$CheckpointModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get radiusMeters => throw _privateConstructorUsedError;
  String get triviaQuestion => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctOptionIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckpointModelCopyWith<CheckpointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckpointModelCopyWith<$Res> {
  factory $CheckpointModelCopyWith(
          CheckpointModel value, $Res Function(CheckpointModel) then) =
      _$CheckpointModelCopyWithImpl<$Res, CheckpointModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      double latitude,
      double longitude,
      double radiusMeters,
      String triviaQuestion,
      List<String> options,
      int correctOptionIndex});
}

/// @nodoc
class _$CheckpointModelCopyWithImpl<$Res, $Val extends CheckpointModel>
    implements $CheckpointModelCopyWith<$Res> {
  _$CheckpointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radiusMeters = null,
    Object? triviaQuestion = null,
    Object? options = null,
    Object? correctOptionIndex = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      triviaQuestion: null == triviaQuestion
          ? _value.triviaQuestion
          : triviaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctOptionIndex: null == correctOptionIndex
          ? _value.correctOptionIndex
          : correctOptionIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckpointModelImplCopyWith<$Res>
    implements $CheckpointModelCopyWith<$Res> {
  factory _$$CheckpointModelImplCopyWith(_$CheckpointModelImpl value,
          $Res Function(_$CheckpointModelImpl) then) =
      __$$CheckpointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      double latitude,
      double longitude,
      double radiusMeters,
      String triviaQuestion,
      List<String> options,
      int correctOptionIndex});
}

/// @nodoc
class __$$CheckpointModelImplCopyWithImpl<$Res>
    extends _$CheckpointModelCopyWithImpl<$Res, _$CheckpointModelImpl>
    implements _$$CheckpointModelImplCopyWith<$Res> {
  __$$CheckpointModelImplCopyWithImpl(
      _$CheckpointModelImpl _value, $Res Function(_$CheckpointModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? radiusMeters = null,
    Object? triviaQuestion = null,
    Object? options = null,
    Object? correctOptionIndex = null,
  }) {
    return _then(_$CheckpointModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      radiusMeters: null == radiusMeters
          ? _value.radiusMeters
          : radiusMeters // ignore: cast_nullable_to_non_nullable
              as double,
      triviaQuestion: null == triviaQuestion
          ? _value.triviaQuestion
          : triviaQuestion // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctOptionIndex: null == correctOptionIndex
          ? _value.correctOptionIndex
          : correctOptionIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckpointModelImpl implements _CheckpointModel {
  const _$CheckpointModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.latitude,
      required this.longitude,
      this.radiusMeters = 50.0,
      required this.triviaQuestion,
      required final List<String> options,
      required this.correctOptionIndex})
      : _options = options;

  factory _$CheckpointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckpointModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final double radiusMeters;
  @override
  final String triviaQuestion;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctOptionIndex;

  @override
  String toString() {
    return 'CheckpointModel(id: $id, title: $title, description: $description, latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, triviaQuestion: $triviaQuestion, options: $options, correctOptionIndex: $correctOptionIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckpointModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.radiusMeters, radiusMeters) ||
                other.radiusMeters == radiusMeters) &&
            (identical(other.triviaQuestion, triviaQuestion) ||
                other.triviaQuestion == triviaQuestion) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctOptionIndex, correctOptionIndex) ||
                other.correctOptionIndex == correctOptionIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      latitude,
      longitude,
      radiusMeters,
      triviaQuestion,
      const DeepCollectionEquality().hash(_options),
      correctOptionIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckpointModelImplCopyWith<_$CheckpointModelImpl> get copyWith =>
      __$$CheckpointModelImplCopyWithImpl<_$CheckpointModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckpointModelImplToJson(
      this,
    );
  }
}

abstract class _CheckpointModel implements CheckpointModel {
  const factory _CheckpointModel(
      {required final String id,
      required final String title,
      required final String description,
      required final double latitude,
      required final double longitude,
      final double radiusMeters,
      required final String triviaQuestion,
      required final List<String> options,
      required final int correctOptionIndex}) = _$CheckpointModelImpl;

  factory _CheckpointModel.fromJson(Map<String, dynamic> json) =
      _$CheckpointModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get radiusMeters;
  @override
  String get triviaQuestion;
  @override
  List<String> get options;
  @override
  int get correctOptionIndex;
  @override
  @JsonKey(ignore: true)
  _$$CheckpointModelImplCopyWith<_$CheckpointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
