import 'package:ch8_form_exercise/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Email and password retain typed input and the password is hidden',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('ฟอร์มล็อกอิน'), findsOneWidget);
    expect(find.text('กรุณาป้อนข้อมูลเข้าระบบ:'), findsOneWidget);
    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(2));

    await tester.enterText(fields.at(0), 'student@example.com');
    await tester.enterText(fields.at(1), 'test-password-123');
    await tester.pump();

    final email = tester.widget<TextFormField>(fields.at(0));
    final password = tester.widget<TextFormField>(fields.at(1));
    expect(email.controller!.text, 'student@example.com');
    expect(password.controller!.text, 'test-password-123');
    expect(
        tester
            .widgetList<EditableText>(find.byType(EditableText))
            .last
            .obscureText,
        isTrue);
    expect(find.byType(ElevatedButton), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Input fields fit on a small phone with the keyboard open',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 640);
    tester.view.viewInsets = const FakeViewPadding(bottom: 320);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    expect(tester.takeException(), isNull);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'mobile@example.com');
    await tester.enterText(fields.at(1), 'mobile-test');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
