import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:melaka_quest/core/services/location_service.dart';
import 'package:melaka_quest/features/map/presentation/controllers/quest_session_controller.dart';
import 'package:melaka_quest/features/quests/domain/quest_repository.dart';
import 'package:melaka_quest/features/map/domain/models/quest_session.dart';
import 'package:melaka_quest/features/quests/domain/models/checkpoint_model.dart';
import '../widgets/checkpoint_reached_modal.dart';
import 'package:melaka_quest/features/profile/presentation/controllers/badge_unlock_controller.dart';
import 'package:melaka_quest/features/profile/presentation/widgets/badge_unlocked_dialog.dart';

class LiveMapScreen extends ConsumerStatefulWidget {
  final String questId;
  const LiveMapScreen({super.key, required this.questId});

  @override
  ConsumerState<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends ConsumerState<LiveMapScreen> {
  final MapController _mapController = MapController();
  bool _isMapReady = false;
  bool _showingDialog = false;

  @override
  void initState() {
    super.initState();
    _initQuest();
  }

  Future<void> _initQuest() async {
    await LocationService.requestLocationPermission();
    final quest = await ref.read(questByIdProvider(widget.questId).future);
    if (quest != null) {
      ref.read(questSessionControllerProvider.notifier).startQuest(quest);
    }
  }

  void _centerOnUser(Position? pos) {
    if (pos != null && _isMapReady) {
      _mapController.move(LatLng(pos.latitude, pos.longitude), 16);
    }
  }

  void _checkProximity(Position userPos) {
    if (_showingDialog) return;

    final session = ref.read(questSessionControllerProvider);
    if (session == null || session.isComplete) return;

    final target = session.quest.checkpoints[session.currentCheckpointIndex];
    final distance = Geolocator.distanceBetween(
      userPos.latitude, userPos.longitude, target.latitude, target.longitude
    );

    if (distance <= target.radiusMeters) {
      _showArrivalDialog(target);
    }
  }

  void _showArrivalDialog(CheckpointModel target) {
    setState(() => _showingDialog = true);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CheckpointReachedModal(
        checkpoint: target,
        onAnswerSelected: (index) => _handleAnswer(index, target),
      ),
    );
  }

  void _handleAnswer(int index, CheckpointModel target) {
    if (index == target.correctOptionIndex) {
      Navigator.pop(context); // Close modal
      ref.read(questSessionControllerProvider.notifier).completeCheckpoint(target.id);
      setState(() => _showingDialog = false);
      
      final session = ref.read(questSessionControllerProvider);
      if (session?.isComplete ?? false) {
        _showQuestComplete();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Correct! Move to the next checkpoint.', style: TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Not quite! Try again.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _showQuestComplete() {
    context.go('/quest-complete/${widget.questId}');
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(questSessionControllerProvider);
    final userPosAsync = ref.watch(userPositionStreamProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Side effect: check proximity when location updates
    userPosAsync.whenData((pos) {
      if (pos != null) _checkProximity(pos);
    });

    // Listen for badge unlocks
    ref.listen(badgeUnlockControllerProvider, (previous, next) {
      if (next != null) {
        BadgeUnlockedDialog.show(context, next);
        ref.read(badgeUnlockControllerProvider.notifier).clear();
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: colorScheme.surface.withOpacity(0.7),
              elevation: 0,
              title: Text(
                session?.quest.title ?? 'Quest Map',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildMap(session, userPosAsync.value, colorScheme),
          if (session != null) _buildBottomPanel(session, userPosAsync.value, theme, colorScheme),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 220),
        child: FloatingActionButton(
          onPressed: () => _centerOnUser(userPosAsync.value),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget _buildMap(QuestSession? session, Position? userPos, ColorScheme colorScheme) {
    final checkpoints = session?.quest.checkpoints ?? [];
    final userLatLng = userPos != null ? LatLng(userPos.latitude, userPos.longitude) : null;

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: checkpoints.isNotEmpty 
            ? LatLng(checkpoints.first.latitude, checkpoints.first.longitude)
            : const LatLng(2.1896, 102.2501),
        initialZoom: 15,
        onMapReady: () => setState(() => _isMapReady = true),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.example.melaka_quest',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        CircleLayer(
          circles: checkpoints.map((cp) {
            final isCompleted = session?.completedCheckpointIds.contains(cp.id) ?? false;
            final isTarget = session?.currentCheckpointIndex == checkpoints.indexOf(cp) && !(session?.isComplete ?? false);
            final color = isCompleted ? colorScheme.secondaryContainer : (isTarget ? colorScheme.primary : Colors.grey);
            return CircleMarker(
              point: LatLng(cp.latitude, cp.longitude),
              radius: cp.radiusMeters,
              useRadiusInMeter: true,
              color: color.withOpacity(0.1),
              borderColor: color.withOpacity(0.3),
              borderStrokeWidth: 2,
            );
          }).toList(),
        ),
        MarkerLayer(
          markers: [
            if (userLatLng != null)
              Marker(
                point: userLatLng,
                width: 40,
                height: 40,
                child: _buildUserMarker(colorScheme),
              ),
            ...checkpoints.asMap().entries.map((entry) {
              final index = entry.key;
              final cp = entry.value;
              final isCompleted = session?.completedCheckpointIds.contains(cp.id) ?? false;
              final isTarget = session?.currentCheckpointIndex == index && !session!.isComplete;
              
              return Marker(
                point: LatLng(cp.latitude, cp.longitude),
                width: 40,
                height: 40,
                child: _buildCheckpointMarker(index + 1, isCompleted, isTarget, colorScheme),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildUserMarker(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.2), 
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: colorScheme.primary.withOpacity(0.5), blurRadius: 10, spreadRadius: 2),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(color: colorScheme.surface, shape: BoxShape.circle),
        padding: const EdgeInsets.all(2),
        child: Container(decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle)),
      ),
    );
  }

  Widget _buildCheckpointMarker(int number, bool isCompleted, bool isTarget, ColorScheme colorScheme) {
    final color = isCompleted ? colorScheme.secondaryContainer : (isTarget ? colorScheme.primary : Colors.grey);
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.location_on, color: color, size: isTarget ? 45 : 35),
        Positioned(
          top: isTarget ? 8 : 6,
          child: Text(
            '$number',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel(QuestSession session, Position? userPos, ThemeData theme, ColorScheme colorScheme) {
    final progress = session.completedCheckpointIds.length / session.quest.checkpointCount;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 220,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface.withOpacity(0.85),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.5))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quest Progress', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      '${session.completedCheckpointIds.length} / ${session.quest.checkpointCount}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress, 
                    minHeight: 8,
                    backgroundColor: colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: session.quest.checkpoints.length,
                    itemBuilder: (context, index) {
                      final cp = session.quest.checkpoints[index];
                      final isCompleted = session.completedCheckpointIds.contains(cp.id);
                      final isTarget = session.currentCheckpointIndex == index && !session.isComplete;
                      
                      double? distance;
                      if (userPos != null) {
                        distance = Geolocator.distanceBetween(
                          userPos.latitude, userPos.longitude, cp.latitude, cp.longitude
                        );
                      }

                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isTarget ? colorScheme.primary.withOpacity(0.1) : colorScheme.surfaceVariant.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isTarget ? colorScheme.primary.withOpacity(0.5) : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CP ${index + 1}: ${cp.title}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 14,
                                color: isCompleted ? colorScheme.secondaryContainer : (isTarget ? colorScheme.primary : colorScheme.onSurfaceVariant),
                              ),
                            ),
                            const Spacer(),
                            if (isCompleted)
                              Icon(Icons.check_circle, color: colorScheme.secondaryContainer, size: 18)
                            else if (distance != null)
                              Text(
                                '${distance.toInt()}m away', 
                                style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
