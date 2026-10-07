import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'badge_model.freezed.dart';
part 'badge_model.g.dart';

@freezed
class BadgeModel with _$BadgeModel {
  const factory BadgeModel({
    required String id,
    required String name,
    required String description,
    required String iconUrl,
    required String requirementDescription,
    @Default(Colors.amber) @JsonKey(includeFromJson: false, includeToJson: false) Color color,
  }) = _BadgeModel;

  factory BadgeModel.fromJson(Map<String, dynamic> json) => _$BadgeModelFromJson(json);
}

final List<BadgeModel> predefinedBadges = [
  const BadgeModel(
    id: 'first_quest',
    name: 'First Discovery',
    description: 'Completed your very first heritage quest!',
    iconUrl: 'https://cdn-icons-png.flaticon.com/512/3112/3112946.png',
    requirementDescription: 'Complete 1 Quest',
    color: Colors.amber,
  ),
  const BadgeModel(
    id: 'river_master',
    name: 'River Master',
    description: 'Mastered the secrets of the Melaka River.',
    iconUrl: 'https://cdn-icons-png.flaticon.com/512/3112/3112932.png',
    requirementDescription: 'Complete "River Relics Trail"',
    color: Colors.blue,
  ),
  const BadgeModel(
    id: 'heritage_hero',
    name: 'Heritage Hero',
    description: 'A dedicated protector of Melaka\'s heritage.',
    iconUrl: 'https://cdn-icons-png.flaticon.com/512/3112/3112961.png',
    requirementDescription: 'Reach Level 5',
    color: Colors.redAccent,
  ),
  const BadgeModel(
    id: 'jonker_walker',
    name: 'Jonker Walker',
    description: 'Navigated the busy streets of Jonker with ease.',
    iconUrl: 'https://cdn-icons-png.flaticon.com/512/3112/3112953.png',
    requirementDescription: 'Complete "Jonker Street Heritage Walk"',
    color: Colors.deepOrange,
  ),
];
