import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:melaka_quest/features/profile/domain/models/badge_model.dart';

class BadgeUnlockedDialog extends StatelessWidget {
  final BadgeModel badge;

  const BadgeUnlockedDialog({super.key, required this.badge});

  static Future<void> show(BuildContext context, BadgeModel badge) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BadgeUnlockedDialog(badge: badge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: badge.color.withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'NEW BADGE UNLOCKED!',
              style: theme.textTheme.labelLarge?.copyWith(
                color: badge.color,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ).animate().fadeIn().scale().moveY(begin: 10, end: 0),
            const SizedBox(height: 24),
            // Badge Icon Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: badge.color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: badge.color.withOpacity(0.5), width: 2),
              ),
              child: Image.network(
                badge.iconUrl,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.emoji_events, size: 80, color: badge.color),
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2.seconds, color: Colors.white.withOpacity(0.3))
                .shake(hz: 2, curve: Curves.easeInOut),
            const SizedBox(height: 24),
            Text(
              badge.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              badge.description,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: badge.color,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('AWESOME!'),
            ),
          ],
        ),
      ),
    ).animate().scale(curve: Curves.easeOutBack, duration: 600.ms);
  }
}
