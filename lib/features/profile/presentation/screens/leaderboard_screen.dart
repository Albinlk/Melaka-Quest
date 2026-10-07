import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:melaka_quest/features/auth/data/user_repository.dart';
import 'package:melaka_quest/features/auth/domain/models/user_model.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final leaderboardAsync = ref.watch(leaderboardProvider);
    final currentUserAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Hall of Fame', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(leaderboardProvider),
          ),
        ],
      ),
      body: leaderboardAsync.when(
        data: (explorers) => _buildLeaderboardContent(context, explorers, currentUserAsync.value, theme, colorScheme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildLeaderboardContent(BuildContext context, List<UserModel> explorers, UserModel? currentUser,
      ThemeData theme, ColorScheme colorScheme) {
    // Actually theme here should be ThemeData, let's fix that below if needed but it's passed from build
    final actualTheme = Theme.of(context);
    
    if (explorers.isEmpty) {
      return const Center(child: Text('No explorers found yet. Be the first!'));
    }

    final top3 = explorers.take(3).toList();
    final theRest = explorers.skip(3).toList();

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          children: [
            const SizedBox(height: 20),
            _buildPodium(top3, actualTheme, colorScheme),
            const SizedBox(height: 40),
            ...theRest.asMap().entries.map((entry) {
              final index = entry.key + 4; // Start from 4th place
              final user = entry.value;
              return _buildLeaderboardTile(user, index, currentUser?.uid == user.uid, actualTheme, colorScheme);
            }),
          ],
        ),
        if (currentUser != null)
          _buildStickyUserRank(explorers, currentUser, actualTheme, colorScheme),
      ],
    );
  }

  Widget _buildPodium(List<UserModel> top3, ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (top3.length > 1) _buildPodiumItem(top3[1], 2, 140, theme, colorScheme),
        if (top3.isNotEmpty) _buildPodiumItem(top3[0], 1, 180, theme, colorScheme),
        if (top3.length > 2) _buildPodiumItem(top3[2], 3, 120, theme, colorScheme),
      ],
    );
  }

  Widget _buildPodiumItem(UserModel user, int rank, double height, ThemeData theme, ColorScheme colorScheme) {
    final color = rank == 1 ? Colors.amber : (rank == 2 ? Colors.grey[400] : Colors.brown[300]);
    
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CircleAvatar(
              radius: rank == 1 ? 45 : 35,
              backgroundColor: color,
              child: CircleAvatar(
                radius: rank == 1 ? 42 : 32,
                backgroundColor: colorScheme.surface,
                child: Icon(Icons.person, size: rank == 1 ? 50 : 40, color: color),
              ),
            ),
            Positioned(
              top: -5,
              child: Icon(Icons.workspace_premium, color: color, size: 30),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(user.safeName, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text('${user.totalXp} XP', style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.primary)),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color?.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: color!.withOpacity(0.5)),
          ),
          child: Center(
            child: Text('#$rank', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTile(UserModel user, int rank, bool isCurrentUser, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isCurrentUser ? colorScheme.primaryContainer.withOpacity(0.3) : colorScheme.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isCurrentUser ? colorScheme.primary : colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Text('#$rank', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant)),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: colorScheme.surface,
            child: Icon(Icons.person, color: colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(user.safeName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
          Text('${user.totalXp} XP', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary)),
        ],
      ),
    );
  }

  Widget _buildStickyUserRank(List<UserModel> explorers, UserModel currentUser, ThemeData theme, ColorScheme colorScheme) {
    final rankIndex = explorers.indexWhere((u) => u.uid == currentUser.uid);
    final rank = rankIndex == -1 ? '?' : '${rankIndex + 1}';

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(rank, style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Ranking', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text(currentUser.safeName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            Text('${currentUser.totalXp} XP', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
