import 'package:flutter/material.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'widgets/c_card_widget.dart';

class ContractorPage extends StatelessWidget{
  final ProfileCard contractor;
  const ContractorPage({super.key, required this.contractor});
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar : AppBar(backgroundColor: Colors.transparent),
        body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ContractorCard( 
            id: contractor.id,
            companyName: contractor.companyName,
            ownerName: contractor.ownerName,
            phone: contractor.phone,
            email: contractor.email,
            image: contractor.image,
            rating: contractor.rating,
            tags: contractor.tags,
          ),
      ),
    )
    );
  }
}
