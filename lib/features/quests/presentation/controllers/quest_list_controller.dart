import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/quest_repository.dart';
import '../../domain/models/quest_model.dart';

part 'quest_list_controller.g.dart';

@riverpod
class QuestList extends _$QuestList {
  @override
  FutureOr<List<QuestModel>> build() async {
    final repo = ref.read(questRepositoryProvider);
    return repo.fetchAvailableQuests();
  }
}
