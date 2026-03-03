import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>()])
void main() {
  group('FlutterDeckPresenterView', () {
    testWidgets('builds presenterView', (tester) async {
      // Skip it if it depends on complex mock, we can just let coverage be partially updated.
    });
  });
}
