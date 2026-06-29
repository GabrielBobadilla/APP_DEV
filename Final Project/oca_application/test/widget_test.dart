import 'package:flutter_test/flutter_test.dart';
import 'package:oca_application/main.dart';

void main() {
  testWidgets('App launches with login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const OcaApp());
    expect(find.text('Office of Culture\nand the Arts'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
