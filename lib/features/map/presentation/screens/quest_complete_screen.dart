import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melaka_quest/features/quests/domain/quest_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:melaka_quest/features/profile/data/journal_repository.dart';
import 'package:melaka_quest/features/profile/domain/models/journal_entry.dart';
import 'package:melaka_quest/features/auth/data/auth_repository.dart';
import 'package:uuid/uuid.dart';

final selectedImageProvider = StateProvider<XFile?>((ref) => null);
final isUploadingProvider = StateProvider<bool>((ref) => false);

class QuestCompleteScreen extends ConsumerWidget {
  final String questId;
  const QuestCompleteScreen({super.key, required this.questId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final questAsync = ref.watch(questByIdProvider(questId));

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: questAsync.when(
        data: (quest) {
          if (quest == null) return const Center(child: Text('Quest not found.'));
          return _buildContent(context, ref, quest, theme, colorScheme);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, quest, ThemeData theme, ColorScheme colorScheme) {
    return Stack(
      children: [
        // Background Glow
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  colorScheme.secondaryContainer.withOpacity(0.15),
                  colorScheme.background,
                ],
                center: const Alignment(0, -0.3),
                radius: 1.0,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                // Celebration Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primaryContainer.withOpacity(0.4),
                      border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.5), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.secondaryContainer.withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(Icons.emoji_events, color: colorScheme.secondaryContainer, size: 100),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'Quest Completed!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'You have successfully explored all checkpoints in\n${quest.title}.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // Memory Capture Section
                _buildMemoryCapture(context, ref, quest, theme, colorScheme),
                const Spacer(),
                // Return Button
                _buildReturnButton(context, ref, colorScheme, theme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemoryCapture(BuildContext context, WidgetRef ref, quest, ThemeData theme, ColorScheme colorScheme) {
    final selectedImage = ref.watch(selectedImageProvider);
    final isUploading = ref.watch(isUploadingProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text('Capture a Memory', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (selectedImage == null)
            OutlinedButton.icon(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                );
                if (image != null) {
                  ref.read(selectedImageProvider.notifier).state = image;
                }
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('TAKE A PHOTO'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          else
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(selectedImage.path), height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                if (isUploading)
                  const CircularProgressIndicator()
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => ref.read(selectedImageProvider.notifier).state = null,
                          child: const Text('RETAKE'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _saveMemory(ref, context, quest),
                          child: const Text('SAVE MEMORY'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _saveMemory(WidgetRef ref, BuildContext context, quest) async {
    final image = ref.read(selectedImageProvider);
    final user = ref.read(authStateProvider).value;
    if (image == null || user == null) return;

    ref.read(isUploadingProvider.notifier).state = true;
    try {
      final repo = ref.read(journalRepositoryProvider);
      final imageUrl = await repo.uploadQuestPhoto(File(image.path), user.uid, quest.id);
      
      final entry = JournalEntry(
        id: const Uuid().v4(),
        questId: quest.id,
        questTitle: quest.title,
        imageUrl: imageUrl,
        timestamp: DateTime.now(),
      );

      await repo.addJournalEntry(entry, user.uid);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Memory saved to your journal!')),
        );
        ref.read(selectedImageProvider.notifier).state = null;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving memory: $e')),
        );
      }
    } finally {
      ref.read(isUploadingProvider.notifier).state = false;
    }
  }

  Widget _buildReturnButton(BuildContext context, WidgetRef ref, ColorScheme colorScheme, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondaryContainer.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.go('/quests'),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          'RETURN TO DASHBOARD',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
