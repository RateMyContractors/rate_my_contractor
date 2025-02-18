import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool upvote_clicked = false;
  bool downvote_clicked = false;
  int upvote_count = 0;
  int downvote_count = 0;
  Color upbuttonColors = Colors.grey;
  Color downbuttonColors = Colors.grey;
  @override
  Widget build(BuildContext context) {
    String date = widget.date;
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (upvote_clicked == true) {
                            upvote_clicked = false;
                            upbuttonColors = Colors.grey;
                            upvote_count = -1;
                          } else {
                            downvote_clicked = false;
                            upvote_clicked = true;
                            downbuttonColors = Colors.grey;
                            upbuttonColors = Colors.orange;
                            upvote_count = 1;
                          }
                        });
                        context.read<ReviewsBloc>().add(
                              ReviewsUpButtonPressed(
                                reviewerid: widget.reviewerid,
                                contractorid: widget.contractorid,
                                upbutton: upvote_count,
                              ),
                            );
                      },
                      icon: Icon(
                        Icons.thumb_up,
                        color: upbuttonColors,
                        size: 20,
                      ),
                    ),
                    Text(widget.upvote.toString()),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (downvote_clicked == true) {
                            downvote_clicked = false;
                            downbuttonColors = Colors.grey;
                            downvote_count = -1;
                            print(downvote_clicked);
                          } else {
                            downvote_clicked = true;
                            upvote_clicked = false;
                            upbuttonColors = Colors.grey;
                            downbuttonColors = Colors.orange;
                            downvote_count = 1;
                          }
                        });
                        context.read<ReviewsBloc>().add(
                              ReviewsDownButtonPressed(
                                reviewerid: widget.reviewerid,
                                contractorid: widget.contractorid,
                                downbutton: downvote_count,
                              ),
                            );
                      },
                      icon: Icon(
                        Icons.thumb_down,
                        color: downbuttonColors,
                        size: 20,
                      ),
                    ),
                    Text(widget.downvote.toString()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
