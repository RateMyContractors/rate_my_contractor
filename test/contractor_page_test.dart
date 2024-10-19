/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/contractor_page.dart';

void main(){
  testWidgets('Button is present and triggers navigationg after tapped', (tester)async{
    await tester.pumpWidget(const MaterialApp(
      home: ContractorPage(),
      )
    );
      final expectedWidget = find.text("End of Results");

      await tester.dragUntilVisible(
          expectedWidget, //widget that should be visible before it scrolls
          find.byType(ListView), //scrolling through Listview
          const Offset(0, 100) //0 is starting point, + num is scrolling down
    );
  });
}
*/