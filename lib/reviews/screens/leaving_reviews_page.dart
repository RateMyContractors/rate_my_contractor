import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';

class ReviewFormPage extends StatelessWidget {
  const ReviewFormPage({
    required this.companyName,
    required this.contractorid,
    super.key,
  });
  final String companyName;
  final String contractorid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ReviewsBloc, ReviewsState>(
      listener: (context, state) {
        if (state.status == ReviewsStateStatus.passed) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final username = state.user?.username ?? 'Guest';
          final userid = state.user?.id ?? '';
          return Scaffold(
            body: ReviewForm(
              companyName: companyName,
              size: size,
              contractorid: contractorid,
              userid: userid,
              username: username,
            ),
          );
        },
      ),
    );
  }
}

class ReviewForm extends StatelessWidget {
  const ReviewForm({
    required this.companyName,
    required this.size,
    required this.contractorid,
    required this.userid,
    required this.username,
    super.key,
  });

  final String companyName;
  final Size size;
  final String contractorid;
  final String username;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        return Center(
          child: Container(
            // margin: const EdgeInsets.only(bottom: 70, top: 70),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.95,
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
            //width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Create Review',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      companyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 139, 63, 177),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(height: 10),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      'Overall Rating',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                StarSytem(star: state.rating),
                const SizedBox(height: 15),
                const Divider(height: 10),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      'Add a written review',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'What do you think of the company?',
                    ),
                    onChanged: (comment) {
                      context
                          .read<ReviewsBloc>()
                          .add(ReviewsCommentChanged(comment: comment));
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(height: 10),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      'Add a photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  child: size.width < 800
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.upload,
                                  color: Color.fromARGB(255, 163, 64, 170),
                                  size: 50,
                                  semanticLabel: 'Insert Photo',
                                ),
                                Text('Upload'),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 163, 64, 170),
                                  size: 50,
                                  semanticLabel: 'take_a_picture',
                                ),
                                Text('Take a picture'),
                              ],
                            ),
                          ],
                        )
                      : const Column(
                          children: [
                            Icon(
                              Icons.upload,
                              color: Color.fromARGB(255, 163, 64, 170),
                              size: 50,
                              semanticLabel: 'Insert Photo',
                            ),
                            Text('Upload'),
                          ],
                        ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 163, 64, 170),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ReviewsBloc>(context).add(
                            ReviewsFormButtonPressed(
                              contractorid: contractorid,
                              reviewerid: userid,
                              rating: state.rating,
                              comment: state.comment,
                              upvote: 1,
                              downvote: 1,
                              username: username,
                            ),
                          );
                        },
                        child: const Text('Post'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StarSytem extends StatelessWidget {
  const StarSytem({required this.star, super.key});
  final int star;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: (star == 1 || star == 2 || star == 3 || star == 4 || star == 5)
              ? const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 25,
                )
              : const Icon(Icons.star_border, size: 25, color: Colors.grey),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 1));
          },
        ),
        IconButton(
          icon: (star == 2 || star == 3 || star == 4 || star == 5)
              ? const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 25,
                )
              : const Icon(Icons.star_border, size: 25, color: Colors.grey),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 2));
          },
        ),
        IconButton(
          icon: (star == 3 || star == 4 || star == 5)
              ? const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 25,
                )
              : const Icon(Icons.star_border, size: 25, color: Colors.grey),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 3));
          },
        ),
        IconButton(
          icon: (star == 4 || star == 5)
              ? const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 25,
                )
              : const Icon(Icons.star_border, size: 25, color: Colors.grey),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 4));
          },
        ),
        IconButton(
          icon: (star == 5)
              ? const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 25,
                )
              : const Icon(Icons.star_border, size: 25, color: Colors.grey),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 5));
          },
        ),
      ],
    );
  }
}
