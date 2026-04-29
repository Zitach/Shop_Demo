import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/app.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ShopApp()));
    await tester.pumpAndSettle();
    expect(find.text('Shop Demo'), findsOneWidget);
  });
}
