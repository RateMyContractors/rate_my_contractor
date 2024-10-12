import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/main.dart';


void main() {
  testWidgets('Finding if profile cards exist', (tester)async{
    await tester.pumpWidget(const MaterialApp(
      home: MyHomePage(title: '',),
      )
    );
    expect(find.text('Find who you need'), findsOneWidget);
  });
}
