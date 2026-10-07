import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melaka_quest/features/auth/data/auth_repository.dart';
import 'package:melaka_quest/features/auth/data/user_repository.dart';
import 'package:melaka_quest/features/auth/domain/models/user_model.dart';
import 'package:melaka_quest/features/profile/domain/models/badge_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExplorerProfileScreen extends ConsumerWidget {
  const ExplorerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userProfileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Explorer Profile',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.error),
            onPressed: () => _showSignOutDialog(context, ref),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (user) => user == null
            ? const Center(child: Text('No profile found.'))
            : _buildProfileContent(context, user, theme, colorScheme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Future<void> _showSignOutDialog(BuildContext context, WidgetRef ref) async {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out? Your guest progress might be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
              Navigator.pop(context); // Close dialog
              context.go('/auth');
            },
            child: Text('Sign Out', style: TextStyle(color: colorScheme.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, UserModel user, ThemeData theme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(color: colorScheme.secondaryContainer.withOpacity(0.1), blurRadius: 20),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.person, size: 50, color: colorScheme.secondaryContainer),
                ),
                const SizedBox(height: 16),
                Text(user.safeName,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                const SizedBox(height: 8),
                Text('Level ${user.level} Explorer',
                    style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.secondaryContainer)),
                const SizedBox(height: 12),
                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${user.totalXp % 500}/500 XP',
                            style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                        Text('${user.xpToNextLevel} more to Level ${user.level + 1}',
                            style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (user.totalXp % 500) / 500,
                        minHeight: 8,
                        backgroundColor: colorScheme.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Quests', '${user.completedQuestIds.length}', theme, colorScheme),
                    _buildStatItem('XP', '${user.totalXp}', theme, colorScheme),
                    _buildStatItem('Badges', '${user.unlockedBadges.length}', theme, colorScheme),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          // Badges Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your Badges',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ).animate(delay: 200.ms).fadeIn(),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: predefinedBadges.length,
              itemBuilder: (context, index) {
                final badge = predefinedBadges[index];
                final isUnlocked = user.unlockedBadges.contains(badge.id);
                return _buildBadgeItem(badge, isUnlocked, colorScheme);
              },
            ),
          ).animate(delay: 300.ms).fadeIn().slideX(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          // Menu Options
          _buildMenuOption(context, Icons.card_giftcard, 'Rewards & Vouchers', '/rewards', theme, colorScheme),
          const SizedBox(height: 16),
          _buildMenuOption(context, Icons.menu_book, 'Memory Journal', '/journal', theme, colorScheme),
        ].animate(interval: 100.ms).fadeIn(duration: 400.ms),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        Text(value,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildMenuOption(BuildContext context, IconData icon, String title, String route,
      ThemeData theme, ColorScheme colorScheme) {
    // Actually theme here should be ThemeData, let's fix that below if needed but it's passed from build
    final actualTheme = Theme.of(context);
    return InkWell(
      onTap: () {
        if (route != '#') context.push(route);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colorScheme.secondaryContainer),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: actualTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeItem(BadgeModel badge, bool isUnlocked, ColorScheme colorScheme) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isUnlocked ? badge.color.withOpacity(0.1) : colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? badge.color.withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: isUnlocked
                ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
            child: Image.network(
              badge.iconUrl,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.emoji_events, size: 30, color: isUnlocked ? badge.color : Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            badge.name.split(' ').first,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isUnlocked ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


