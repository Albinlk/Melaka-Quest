import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melaka_quest/features/auth/data/auth_repository.dart';
import '../domain/models/journal_entry.dart';

abstract class JournalRepository {
  Future<String> uploadQuestPhoto(File image, String userId, String questId);
  Future<void> addJournalEntry(JournalEntry entry, String userId);
  Stream<List<JournalEntry>> watchJournalEntries(String userId);
}

class FirestoreJournalRepository implements JournalRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> _userJournal(String userId) =>
      _firestore.collection('users').doc(userId).collection('journal');

  @override
  Future<String> uploadQuestPhoto(File image, String userId, String questId) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final ref = _storage.ref().child('users/$userId/journal/${questId}_$timestamp.jpg');
    final uploadTask = await ref.putFile(image);
    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<void> addJournalEntry(JournalEntry entry, String userId) async {
    await _userJournal(userId).doc(entry.id).set(entry.toJson());
  }

  @override
  Stream<List<JournalEntry>> watchJournalEntries(String userId) {
    return _userJournal(userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JournalEntry.fromJson(doc.data()))
            .toList());
  }
}

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return FirestoreJournalRepository();
});

final journalEntriesProvider = StreamProvider<List<JournalEntry>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(journalRepositoryProvider).watchJournalEntries(user.uid);
});
