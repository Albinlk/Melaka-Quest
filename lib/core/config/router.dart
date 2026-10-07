import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_gate_screen.dart';
import '../../features/quests/presentation/screens/quest_list_screen.dart';
import '../../features/quests/presentation/screens/quest_detail_screen.dart';
import '../../features/map/presentation/screens/live_map_screen.dart';
import '../../features/map/presentation/screens/quest_complete_screen.dart';
import '../../features/profile/presentation/screens/explorer_profile_screen.dart';
import '../../features/profile/presentation/screens/rewards_screen.dart';
import '../../features/profile/presentation/screens/memory_journal_screen.dart';
import '../../features/profile/presentation/screens/leaderboard_screen.dart';
import '../../features/auth/data/auth_repository.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // If we are on splash screen, don't redirect yet (splash screen handles its own routing)
      if (state.uri.path == '/' || state.uri.path == '/onboarding') {
        return null;
      }

      final isAuthenticated = authState.valueOrNull != null;
      final isAuthRoute = state.uri.path == '/auth';

      if (!isAuthenticated && !isAuthRoute) {
        return '/auth';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/quests';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthGateScreen(),
      ),
      GoRoute(
        path: '/quests',
        builder: (context, state) => const QuestListScreen(),
        routes: [
          GoRoute(
            path: ':questId',
            builder: (context, state) {
              final questId = state.pathParameters['questId']!;
              return QuestDetailScreen(questId: questId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/map/:questId',
        builder: (context, state) {
          final questId = state.pathParameters['questId']!;
          return LiveMapScreen(questId: questId);
        },
      ),
      GoRoute(
        path: '/quest-complete/:questId',
        builder: (context, state) {
          final questId = state.pathParameters['questId']!;
          return QuestCompleteScreen(questId: questId);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ExplorerProfileScreen(),
      ),
      GoRoute(
        path: '/rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      GoRoute(
        path: '/journal',
        builder: (context, state) => const MemoryJournalScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
    ],
  );
}
