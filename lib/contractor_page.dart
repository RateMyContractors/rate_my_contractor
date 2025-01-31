import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
import 'package:rate_my_contractor/reviews/screens/leaving_reviews_page.dart';
import 'package:rate_my_contractor/widgets/about_widget.dart';
import 'package:rate_my_contractor/widgets/contractor_card.dart';
import 'package:rate_my_contractor/widgets/portfolio_widget.dart';
import 'package:rate_my_contractor/widgets/rating_widget.dart';
import 'package:rate_my_contractor/widgets/review_card.dart';

class ContractorPage extends StatelessWidget {
  const ContractorPage({required this.contractor, super.key});
  final Contractor contractor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<ReviewFormPage>(
                                builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: context.read<ReviewsBloc>(),
                                    ),
                                    BlocProvider.value(
                                      value: context.read<AuthenticationBloc>(),
                                    ),
                                  ],
                                  child: ReviewFormPage(
                                    contractor: contractor,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Write a review'),
                        ),
                        const Text(
                          'Customer Reviews\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        //call ratingWidget here
                        RatingWidget(
                          rating: contractor.rating,
                          totalRating: contractor.totalRating,
                        ),
                        Visibility(
                          visible: state.status == ReviewsStateStatus.success,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 360,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.reviews.length,
                                    itemBuilder: (context, index) {
                                      // final review =
                                      //     state.reviews[index].reviewerId;
                                      return Center(
                                        child: ReviewCard(
                                          reviewerName:
                                              state.reviews[index].username,
                                          rating: state.reviews[index].rating,
                                          comment: state.reviews[index].comment,
                                          date: state.reviews[index]
                                              .date, //review.date,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
