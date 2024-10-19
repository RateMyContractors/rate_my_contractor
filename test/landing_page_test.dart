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
  testWidgets('Button is present and triggers navigationg after tapped', (tester)async{
    await tester.pumpWidget(const MaterialApp(
      home: MyHomePage(title: '',),),);
      expect(find.text('Find who you need'), findsOneWidget);
      //expect(find.text('filter'), findsNothing);
      final ebfinder = find.byType(ElevatedButton);
      await tester.tap(ebfinder);
      await tester.pumpAndSettle(); //wait for navigation to complete

      expect(find.text('Find who you need'), findsNothing);

  });

}
