import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/main.dart';
import 'package:mockito/mockito.dart' as mockito;

class MockNavigatorObserver extends mockito.Mock implements NavigatorObserver {}

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

    // testWidgets('Button is present and triggers navigation after tapped', (WidgetTester tester) async {
  //     final mockObserver = MockNavigatorObserver();
  //     final Route<dynamic>? route = captureAny();
  //     final BuildContext? context = captureAny();
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: const MyHomePage(title: '',),
  //         navigatorObservers: [mockObserver],
  //       ),
  //     );

  //     expect(find.byType(ElevatedButton), findsOneWidget); //checks for button 
  //     await tester.tap(find.byType(ElevatedButton)); //simulates user tapping the button 
  //     await tester.pumpAndSettle();

  //     verify(() => mockObserver.didPush(route, context));
     
  //     expect(find.byType(ResultsPage), findsOneWidget); 
  //   });


}
