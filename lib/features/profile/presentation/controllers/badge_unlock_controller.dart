import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:melaka_quest/features/profile/domain/models/badge_model.dart';

part 'badge_unlock_controller.g.dart';

@riverpod
class BadgeUnlockController extends _$BadgeUnlockController {
  @override
  BadgeModel? build() => null;

  void showBadge(BadgeModel badge) {
    state = badge;
  }

  void clear() {
    state = null;
  }
}
