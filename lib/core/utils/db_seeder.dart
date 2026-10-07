import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/quests/domain/quest_repository.dart';

class DbSeeder {
  static Future<void> seedQuests() async {
    final firestore = FirebaseFirestore.instance;
    final fakeRepo = FakeQuestRepository();
    final quests = await fakeRepo.fetchAvailableQuests();

    for (final quest in quests) {
      await firestore.collection('quests').doc(quest.id).set(quest.toJson());
      print('Seeded quest: ${quest.title}');
    }
  }
}
