import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melaka_quest/features/auth/data/user_repository.dart';
import 'package:melaka_quest/features/auth/domain/models/user_model.dart';

final leaderboardProvider = FutureProvider<List<UserModel>>((ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getTopExplorers(limit: 50);
});
