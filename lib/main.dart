import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bootstrap.dart';
import 'core/config/router.dart';
import 'core/config/theme.dart';

void main() async {
  final container = await bootstrap();
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MelakaQuestApp(),
    ),
  );
}

class MelakaQuestApp extends ConsumerWidget {
  const MelakaQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Melaka Quest',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
