import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/models/contractor.dart';

void main() {
  var testContractor = const Contractor(
    id: 4,
    companyName: "Handy Home Repairs",
    ownerName: "Mike Johnson",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.8,
    tags: ["General Repairs", "Carpentry", "Painting"],
    phone: '',
    email: '',
    aboutUs: 'blah blah blah',
  );

  testWidgets('Contractor card appears on the page', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContractorPage(contractor: testContractor),
    ));
    expect(find.text("Handy Home Repairs"), findsOneWidget);
  });

  testWidgets('About us appears on the page', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContractorPage(contractor: testContractor),
    ));
    expect(find.text("About Us\n"), findsOneWidget);
  });

  testWidgets('Portfolio appears on the page', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ContractorPage(contractor: testContractor),
    ));
    await tester.pumpAndSettle();
    expect(find.text("Portfolio\n"), findsOneWidget);
  });
}
