import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/quest_repository_impl.dart';
import 'models/quest_model.dart';
import 'models/checkpoint_model.dart';

abstract class QuestRepository {
  Future<List<QuestModel>> fetchAvailableQuests();
}

class FakeQuestRepository implements QuestRepository {
  @override
  Future<List<QuestModel>> fetchAvailableQuests() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const QuestModel(
        id: 'q1',
        title: 'River Relics Trail',
        summary: 'Explore the historical river path and discover hidden gems.',
        imageUrl: 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?q=80&w=500',
        estimatedDurationMinutes: 45,
        checkpoints: [
          CheckpointModel(
            id: 'cp1',
            title: 'Taman Rempah',
            description: 'Starting point of the cruise with a beautiful spice garden.',
            latitude: 2.2064,
            longitude: 102.2505,
            radiusMeters: 50,
            triviaQuestion: 'What does Taman Rempah mean?',
            options: ['Spice Garden', 'River Park', 'Old Town'],
            correctOptionIndex: 0,
          ),
          CheckpointModel(
            id: 'cp2',
            title: 'Shore Sky Tower',
            description: 'The tallest building in Melaka with a 360-degree view.',
            latitude: 2.2023,
            longitude: 102.2497,
            radiusMeters: 50,
            triviaQuestion: 'How many floors does the Shore Sky Tower have?',
            options: ['42', '43', '44'],
            correctOptionIndex: 1,
          ),
        ],
      ),
      const QuestModel(
        id: 'q2',
        title: 'Jonker Street Heritage Walk',
        summary: 'Walk through the heart of Melaka\'s history and culture.',
        imageUrl: 'https://images.unsplash.com/photo-1541018939203-36eeab6d5f21?q=80&w=500',
        estimatedDurationMinutes: 30,
        checkpoints: [
          CheckpointModel(
            id: 'cp3',
            title: 'Christ Church',
            description: 'The iconic red church built by the Dutch.',
            latitude: 2.1942,
            longitude: 102.2493,
            radiusMeters: 40,
            triviaQuestion: 'What color is Christ Church?',
            options: ['Red', 'Blue', 'White'],
            correctOptionIndex: 0,
          ),
          CheckpointModel(
            id: 'cp4',
            title: 'Stadthuys',
            description: 'Former city hall and governor\'s residence.',
            latitude: 2.1939,
            longitude: 102.2495,
            radiusMeters: 40,
            triviaQuestion: 'When was Stadthuys built?',
            options: ['1650', '1750', '1850'],
            correctOptionIndex: 0,
          ),
        ],
      ),
    ];
  }
}

final questRepositoryProvider = Provider<QuestRepository>((ref) {
  return FirestoreQuestRepository(FirebaseFirestore.instance);
});

final questByIdProvider = FutureProvider.family<QuestModel?, String>((ref, id) async {
  final repo = ref.watch(questRepositoryProvider);
  final quests = await repo.fetchAvailableQuests();
  try {
    return quests.firstWhere((q) => q.id == id);
  } catch (_) {
    return null;
  }
});
