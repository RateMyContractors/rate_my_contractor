import 'package:flutter/material.dart';
import 'widgets/about_widget.dart';
import 'widgets/c_card_widget.dart';
import 'widgets/portfolio_widget.dart';
import 'package:rate_my_contractor/results_page.dart';

class ContractorPage extends StatelessWidget {
  final ProfileCard contractor;
  const ContractorPage({super.key, required this.contractor});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(0, 255, 255, 255),
            margin: const EdgeInsets.only(right: 120, left:120, top: 20),
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
                  tags: contractor.tags,),
                const SizedBox(height:20),
                AboutUsWidget(
                  aboutUs: contractor.aboutUs,
                ),
                const SizedBox(height:20),
                const PortfolioWidget(),
              ],
            ),
          ),
        ),
    );
  }
}