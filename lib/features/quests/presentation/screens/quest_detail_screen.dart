import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/quest_repository.dart';
import '../../domain/models/quest_model.dart';

class QuestDetailScreen extends ConsumerWidget {
  final String questId;
  const QuestDetailScreen({super.key, required this.questId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questAsync = ref.watch(questByIdProvider(questId));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: questAsync.when(
        data: (quest) {
          if (quest == null) return const Center(child: Text('Quest not found.'));
          return _buildContent(context, quest, theme, colorScheme);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: colorScheme.error))),
      ),
    );
  }

  Widget _buildContent(BuildContext context, QuestModel quest, ThemeData theme, ColorScheme colorScheme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 350,
          pinned: true,
          backgroundColor: colorScheme.surface,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            title: Text(
              quest.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [const Shadow(color: Colors.black, blurRadius: 20)],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: quest.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: colorScheme.surfaceVariant),
                  errorWidget: (context, url, error) => Container(
                    color: colorScheme.surfaceVariant,
                    child: Icon(Icons.error, color: colorScheme.onSurfaceVariant),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        colorScheme.background,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(context, quest, theme, colorScheme),
                const SizedBox(height: 32),
                Text(
                  'About this Quest',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  quest.summary,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Checkpoints (${quest.checkpointCount})',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final cp = quest.checkpoints[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primaryContainer.withOpacity(0.5),
                          border: Border.all(color: colorScheme.primary.withOpacity(0.5)),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        cp.title,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          cp.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: quest.checkpoints.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.secondaryContainer.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.push('/map/${quest.id}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondaryContainer,
                  foregroundColor: colorScheme.onSecondaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  'START QUEST',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, QuestModel quest, ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(Icons.timer_outlined, '${quest.estimatedDurationMinutes} min', theme, colorScheme),
          Container(height: 40, width: 1, color: colorScheme.outlineVariant.withOpacity(0.5)),
          _infoItem(Icons.location_on_outlined, '${quest.checkpointCount} stops', theme, colorScheme),
          Container(height: 40, width: 1, color: colorScheme.outlineVariant.withOpacity(0.5)),
          _infoItem(Icons.star_outline, 'Easy', theme, colorScheme),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text, ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        Icon(icon, color: colorScheme.secondaryContainer, size: 28),
        const SizedBox(height: 8),
        Text(
          text,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
