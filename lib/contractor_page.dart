import 'package:flutter/material.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/widgets/about_widget.dart';
import 'package:rate_my_contractor/widgets/contractor_card.dart';
import 'package:rate_my_contractor/widgets/portfolio_widget.dart';
//import 'models/contractor.dart';

class ContractorPage extends StatelessWidget {
  const ContractorPage({required this.contractor, super.key});
  final Contractor contractor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(0, 255, 255, 255),
          margin: const EdgeInsets.only(right: 120, left: 120, top: 20),
          child: Column(
            children: [
              ContractorCard(
                id: contractor.id,
                companyName: contractor.companyName,
                ownerName: contractor.ownerName,
                phone: contractor.phone,
                email: contractor.email,
                image: contractor.image,
                rating: contractor.rating,
                tags: contractor.tags,
              ),
              const SizedBox(height: 20),
              const AboutUsWidget(
                aboutUs: 'this is about us',
              ),
              const SizedBox(height: 20),
              const PortfolioWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
