import 'package:flutter_test/flutter_test.dart';
import 'package:reps_event_app/ui/lazy_image.dart';

import '../golden_tests_utils.dart';

void main() {
  testWidgets('Lazy image test', (WidgetTester tester) async {
    GoldenTestsUtils.testWidgetWithGolden<LazyImage>(
      tester: tester,
      goldenName: 'lazy_image_golden',
      widgetToTest: LazyImage(
        imageUrl:
            'https://dejagerart.com/wp-content/uploads/2018/09/Test-Logo-Circle-black-transparent.png',
      ),
    );
  });
}
