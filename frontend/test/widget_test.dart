import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ShopApp()));
    expect(find.text('Shop Demo'), findsOneWidget);
  });
}
