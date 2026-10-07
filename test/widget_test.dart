import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:melaka_quest/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      // Build our app wrapped in ProviderScope since we use Riverpod
      await tester.pumpWidget(const ProviderScope(child: MelakaQuestApp()));

      // Verify that our app starts and shows the 'MELAKA QUEST' text on the splash screen
      expect(find.text('MELAKA QUEST'), findsOneWidget);
      
      // Wait for the splash screen timer to finish
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });
  });
}
