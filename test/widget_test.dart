import 'package:flutter_test/flutter_test.dart';
import 'package:nan/app.dart';

void main() {
  testWidgets('Uygulama başlatma testi', (WidgetTester tester) async {
    await tester.pumpWidget(const NanYiyorumApp());
    expect(find.text('Nan Yiyorum'), findsOneWidget);
  });
}
