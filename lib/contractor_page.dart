import 'package:flutter/material.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/reviews/screens/leaving_reviews_page.dart';
import 'package:rate_my_contractor/widgets/rating_widget.dart';
import 'package:rate_my_contractor/widgets/review_card.dart';
import 'widgets/about_widget.dart';
import 'widgets/contractor_card.dart';
import 'widgets/portfolio_widget.dart';
//import 'models/contractor.dart';

class ContractorPage extends StatelessWidget {
  final Contractor contractor;
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
                aboutUs: "this is about us",
              ),
              const SizedBox(height: 20),
              const PortfolioWidget(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewFormPage(
                                    companyName: contractor.companyName)),
                          );
                        },
                        child: const Text('Write a review')),
                    const Text("Customer Reviews\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                    //call ratingWidget here
                    const RatingWidget(
                        rating: [2, 5, 4, 2, 3, 5, 4, 1, 1, 5, 1, 4, 3]),
                    ReviewCard(
                        reviewerName: 'John Smith',
                        rating: 4,
                        comment: 'They are great',
                        date: '01/2/2025'),
                    ReviewCard(
                        reviewerName: 'Mary Jenkings',
                        rating: 3,
                        comment: 'Loved their work ',
                        date: '01/2/2025'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
