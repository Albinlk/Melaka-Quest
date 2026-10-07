import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/models/quest_model.dart';
import '../domain/quest_repository.dart';

class FirestoreQuestRepository implements QuestRepository {
  final FirebaseFirestore _firestore;

  FirestoreQuestRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _quests => _firestore.collection('quests');

  @override
  Future<List<QuestModel>> fetchAvailableQuests() async {
    final querySnapshot = await _quests.get();
    return querySnapshot.docs
        .map((doc) => QuestModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }
}
