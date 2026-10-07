import 'package:melaka_quest/features/auth/domain/models/user_model.dart';
import 'package:melaka_quest/features/profile/domain/models/badge_model.dart';

class BadgeService {
  /// Returns a list of badges the user is eligible for but hasn't unlocked yet.
  List<BadgeModel> checkNewBadges(UserModel user) {
    final List<BadgeModel> newBadges = [];
    
    for (final badge in predefinedBadges) {
      // Skip if already unlocked
      if (user.unlockedBadges.contains(badge.id)) continue;
      
      // Check eligibility
      if (_isEligible(user, badge.id)) {
        newBadges.add(badge);
      }
    }
    
    return newBadges;
  }

  bool _isEligible(UserModel user, String badgeId) {
    switch (badgeId) {
      case 'first_quest':
        return user.completedQuestIds.isNotEmpty;
      case 'river_master':
        return user.completedQuestIds.any((id) => id.contains('river-relics'));
      case 'heritage_hero':
        return user.level >= 5;
      case 'jonker_walker':
        return user.completedQuestIds.any((id) => id.contains('jonker-street'));
      default:
        return false;
    }
  }
}
