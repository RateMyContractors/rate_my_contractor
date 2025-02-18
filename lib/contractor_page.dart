import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
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
    const scrollPhysics = NeverScrollableScrollPhysics();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, state) {
          final reviews = state.reviews;
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
                  AboutUsWidget(
                    aboutUs: contractor.aboutUs ?? '',
                  ),
                  const SizedBox(height: 20),
                  PortfolioWidget(image: contractor.image),
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
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            final username = state.user?.username;
                            return TextButton(
                              onPressed: () {
                                if (state.status !=
                                    AuthenticationStatus.authenticated) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Please log in to write a review.',
                                      ),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<LoginPage>(
                                              builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        AuthenticationBloc>(
                                                      context,
                                                    ),
                                                  ),
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        SearchBloc>(context),
                                                  ),
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        ReviewsBloc>(context),
                                                  ),
                                                ],
                                                child: LoginPage(
                                                  contractor: contractor,
                                                  route: 'reviewcontractor',
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (reviews.any(
                                  (review) => review.username == username,
                                )) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Thank you for the review'),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<ReviewFormPage>(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: BlocProvider.of<ReviewsBloc>(
                                            context,
                                          ),
                                        ),
                                        BlocProvider.value(
                                          value: BlocProvider.of<
                                              AuthenticationBloc>(context),
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
                            );
                          },
                        ),
                        const Text(
                          'Customer Reviews\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Visibility(
                          visible: state.status == ReviewsStateStatus.success,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingWidget(
                                entirerating: state.reviews,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 360,
                                  child: Builder(
                                    builder: (context) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: scrollPhysics,
                                        itemCount: state.reviews.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: ReviewCard(
                                              reviewerName:
                                                  state.reviews[index].username,
                                              rating:
                                                  state.reviews[index].rating,
                                              comment:
                                                  state.reviews[index].comment,
                                              date: state.reviews[index].date,
                                              usertype:
                                                  state.reviews[index].usertype,
                                              upvote:
                                                  state.reviews[index].upvote,
                                              downvote:
                                                  state.reviews[index].downvote,
                                              reviewerid: state
                                                  .reviews[index].reviewerId,
                                              contractorid: state
                                                  .reviews[index].contractorId,
                                            ),
                                          );
                                        },
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
