import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:melaka_quest/core/services/persistence_service.dart';
// import 'package:melaka_quest/core/utils/db_seeder.dart'; // Uncomment when seeding

/// Bootstrap function to initialize global services before app start
Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Persistence
  await PersistenceService.init();
  
  // Initialize Firebase here
  try {
    await Firebase.initializeApp();
    // UNCOMMENT the line below to seed Firestore with mock quest data (RUN ONCE)
    // await DbSeeder.seedQuests();
  } catch (e) {
    debugPrint('Firebase init error: $e');
    debugPrint('Make sure you have run `flutterfire configure`.');
  }

  final container = ProviderContainer();
  // We can pre-load providers here if needed
  
  return container;
}
