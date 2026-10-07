import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/user_model.dart';
import 'auth_repository.dart';
import '../../profile/application/badge_service.dart';

abstract class UserRepository {
  Future<UserModel?> getUserProfile(String uid);
  Future<void> createUserProfile(UserModel user);
  Future<void> updateUserProfile(UserModel user);
  /// Atomically add XP — safe against concurrent writes
  Future<void> incrementXp(String uid, int xp);
  /// Atomically mark a quest as completed — safe against duplicates
  Future<void> addCompletedQuest(String uid, String questId);
  /// Atomically add an unlocked badge
  Future<void> addUnlockedBadge(String uid, String badgeId);
  /// Real-time stream of the user profile document
  Stream<UserModel?> watchUserProfile(String uid);
  /// Create profile if it doesn't exist yet (idempotent)
  Future<void> createOrFetchProfile(String uid, {String? displayName, String? email});
  /// Get top explorers by XP
  Future<List<UserModel>> getTopExplorers({int limit = 20});
}

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirestoreUserRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> createUserProfile(UserModel user) async {
    await _users.doc(user.uid).set(user.toJson());
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    await _users.doc(user.uid).update(user.toJson());
  }

  @override
  Future<void> incrementXp(String uid, int xp) async {
    await _users.doc(uid).update({
      'totalXp': FieldValue.increment(xp),
    });
  }

  @override
  Future<void> addCompletedQuest(String uid, String questId) async {
    await _users.doc(uid).update({
      'completedQuestIds': FieldValue.arrayUnion([questId]),
    });
  }

  @override
  Future<void> addUnlockedBadge(String uid, String badgeId) async {
    await _users.doc(uid).update({
      'unlockedBadges': FieldValue.arrayUnion([badgeId]),
    });
  }

  @override
  Stream<UserModel?> watchUserProfile(String uid) {
    return _users.doc(uid).snapshots().map((snap) {
      if (snap.exists && snap.data() != null) {
        return UserModel.fromJson(snap.data()!);
      }
      return null;
    });
  }

  @override
  Future<void> createOrFetchProfile(String uid, {String? displayName, String? email}) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) {
      final newUser = UserModel(
        uid: uid,
        displayName: displayName,
        email: email,
      );
      await _users.doc(uid).set(newUser.toJson());
    }
  }

  @override
  Future<List<UserModel>> getTopExplorers({int limit = 20}) async {
    final query = await _users.orderBy('totalXp', descending: true).limit(limit).get();
    return query.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirestoreUserRepository(FirebaseFirestore.instance);
});

/// Real-time stream of the authenticated user's Firestore profile
final userProfileProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final uid = authState.valueOrNull?.uid;
  if (uid == null) return Stream.value(null);
  return ref.watch(userRepositoryProvider).watchUserProfile(uid);
});

final badgeServiceProvider = Provider((ref) => BadgeService());

