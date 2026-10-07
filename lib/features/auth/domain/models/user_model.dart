import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math' as math;

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    String? email,
    String? displayName,
    @Default(0) int totalXp,
    @Default([]) List<String> unlockedBadges,
    @Default([]) List<String> completedQuestIds,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

/// Extension to derive computed fields without storing them in Firestore
extension UserModelX on UserModel {
  /// Level = 1 + floor(totalXp / 500), max level 50
  int get level => math.min(50, 1 + (totalXp ~/ 500));

  /// XP needed for next level
  int get xpToNextLevel => (level * 500) - totalXp;

  /// Display name fallback
  String get safeName => displayName ?? 'Explorer';
}

