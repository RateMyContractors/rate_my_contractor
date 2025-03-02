import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.usertype,
    required this.upvote,
    required this.downvote,
    required this.reviewerid,
    required this.contractorid,
    required this.reviewid,
    required this.upvoteClicked,
    required this.downvoteClicked,
    super.key,
    this.image,
  });
  final String reviewerName;
  final int rating;
  final String comment;
  final String? image;
  final String date;
  final String usertype;
  final int upvote;
  final int downvote;
  final String contractorid;
  final String reviewerid;
  final String reviewid;
  final bool upvoteClicked;
  final bool downvoteClicked;

  @override
  ReviewCardState createState() => ReviewCardState();
}

class ReviewCardState extends State<ReviewCard> {
  bool upvoteclicked = false;
  bool downvoteclicked = false;
  int upvotecount = 0;
  int downvotecount = 0;
  Color upbuttonColors = Colors.grey;
  Color downbuttonColors = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final date = widget.date;

    final reviewImages = <String>[
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
    ];
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        return Container(
          //color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            //border: Border.all(color: Colors.grey, width: 0.02)
          ),
          child: Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          widget.reviewerName,
                          style: GoogleFonts.libreFranklin(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: widget.usertype != 'EMPTY',
                          child: Text(
                            widget.usertype,
                            style: GoogleFonts.libreFranklin(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: const Color.fromARGB(255, 248, 137, 94),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(
                    5,
                    (starIndex) => Icon(
                      Icons.star,
                      color: starIndex < widget.rating
                          ? Colors.orange
                          : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
                Text(
                  'Reviewed on $date',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Color.fromARGB(255, 167, 160, 163),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.comment,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: 'TimesNewRoman',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: reviewImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(reviewImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (c, state) {
                    return Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (state.status !=
                                AuthenticationStatus.authenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Please log in to upvote a review.',
                                  ),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    textColor:
                                        Theme.of(context).colorScheme.primary,
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
                                                value:
                                                    BlocProvider.of<SearchBloc>(
                                                  context,
                                                ),
                                              ),
                                              BlocProvider.value(
                                                value: BlocProvider.of<
                                                    ReviewsBloc>(context),
                                              ),
                                            ],
                                            child: const LoginPage(
                                              route: '',
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
                            thumbsUp(context);
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: widget.upvoteClicked == true
                                ? Colors.orange
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                        Text(widget.upvote.toString()),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            if (state.status !=
                                AuthenticationStatus.authenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Please log in to downvote reviews',
                                  ),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    textColor:
                                        Theme.of(context).colorScheme.primary,
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
                                                value:
                                                    BlocProvider.of<SearchBloc>(
                                                  context,
                                                ),
                                              ),
                                              BlocProvider.value(
                                                value: BlocProvider.of<
                                                    ReviewsBloc>(context),
                                              ),
                                            ],
                                            child: const LoginPage(
                                              route: '',
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
                            thumbsDown(context);
                          },
                          icon: Icon(
                            Icons.thumb_down,
                            color: widget.downvoteClicked == true
                                ? Colors.orange
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                        Text(widget.downvote.toString()),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void thumbsDown(BuildContext context) {
    if (widget.downvoteClicked == false && widget.upvoteClicked == true) {
      context.read<ReviewsBloc>().add(
            ReviewsUpButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              upbutton: -1,
              reviewid: widget.reviewid,
              upbuttonClicked: false,
            ),
          );
      context.read<ReviewsBloc>().add(
            ReviewsDownButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              downbutton: 1,
              reviewid: widget.reviewid,
              downbuttonClicked: true,
            ),
          );
    } else if (widget.downvoteClicked == true) {
      context.read<ReviewsBloc>().add(
            ReviewsDownButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              downbutton: -1,
              reviewid: widget.reviewid,
              downbuttonClicked: false,
            ),
          );
    } else if (widget.downvoteClicked == false) {
      context.read<ReviewsBloc>().add(
            ReviewsDownButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              downbutton: 1,
              reviewid: widget.reviewid,
              downbuttonClicked: true,
            ),
          );
    }
  }

  void thumbsUp(BuildContext context) {
    if (widget.upvoteClicked == false && widget.downvoteClicked == true) {
      context.read<ReviewsBloc>().add(
            ReviewsDownButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              downbutton: -1,
              reviewid: widget.reviewid,
              downbuttonClicked: false,
            ),
          );

      context.read<ReviewsBloc>().add(
            ReviewsUpButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              upbutton: 1,
              reviewid: widget.reviewid,
              upbuttonClicked: true,
            ),
          );
    } else if (widget.upvoteClicked == true) {
      context.read<ReviewsBloc>().add(
            ReviewsUpButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              upbutton: -1,
              reviewid: widget.reviewid,
              upbuttonClicked: false,
            ),
          );
    } else if (widget.upvoteClicked == false) {
      context.read<ReviewsBloc>().add(
            ReviewsUpButtonPressed(
              reviewerid: widget.reviewerid,
              contractorid: widget.contractorid,
              upbutton: 1,
              reviewid: widget.reviewid,
              upbuttonClicked: true,
            ),
          );
    }
  }
}
