import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../quests/domain/models/checkpoint_model.dart';

class CheckpointReachedModal extends StatefulWidget {
  final CheckpointModel checkpoint;
  final Function(int) onAnswerSelected;

  const CheckpointReachedModal({
    super.key,
    required this.checkpoint,
    required this.onAnswerSelected,
  });

  @override
  State<CheckpointReachedModal> createState() => _CheckpointReachedModalState();
}

class _CheckpointReachedModalState extends State<CheckpointReachedModal> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.95),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondaryContainer.withOpacity(0.1),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Holographic icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primaryContainer.withOpacity(0.5),
                  border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(color: colorScheme.secondaryContainer.withOpacity(0.3), blurRadius: 20),
                  ],
                ),
                child: Icon(Icons.auto_awesome, color: colorScheme.secondaryContainer, size: 64),
              ),
              const SizedBox(height: 24),
              Text(
                'Discovery Unlocked!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'at ${widget.checkpoint.title}',
                style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'TRIVIA CHALLENGE',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondaryContainer,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.checkpoint.triviaQuestion,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              ...List.generate(widget.checkpoint.options.length, (index) {
                final isSelected = _selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      Future.delayed(const Duration(milliseconds: 400), () {
                        widget.onAnswerSelected(index);
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? colorScheme.secondaryContainer : colorScheme.surfaceVariant.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? colorScheme.secondaryContainer : colorScheme.outlineVariant.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        widget.checkpoint.options[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? colorScheme.onSecondaryContainer : colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
