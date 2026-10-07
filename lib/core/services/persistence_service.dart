import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melaka_quest/features/map/domain/models/quest_session.dart';

class PersistenceService {
  static const String _sessionBoxName = 'quest_session_box';
  static const String _sessionKey = 'active_session';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_sessionBoxName);
  }

  static Future<void> saveSession(QuestSession session) async {
    final box = Hive.box(_sessionBoxName);
    final jsonString = jsonEncode(session.toJson());
    await box.put(_sessionKey, jsonString);
  }

  static QuestSession? loadSession() {
    final box = Hive.box(_sessionBoxName);
    final jsonString = box.get(_sessionKey) as String?;
    if (jsonString == null) return null;
    
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return QuestSession.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  static Future<void> clearSession() async {
    final box = Hive.box(_sessionBoxName);
    await box.delete(_sessionKey);
  }
}
