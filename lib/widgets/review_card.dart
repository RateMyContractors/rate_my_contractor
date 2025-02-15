import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
    required this.usertype,
    required this.upvote,
    required this.downvote,
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

  @override
  Widget build(BuildContext context) {
    final reviewImages = <String>[
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
    ];
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
                      reviewerName,
                      style: GoogleFonts.libreFranklin(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Visibility(
                      visible: usertype != 'EMPTY',
                      child: Text(
                        usertype,
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
                  color: starIndex < rating ? Colors.orange : Colors.grey,
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
              comment,
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
                  onPressed: null,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.grey[350],
                    size: 20,
                  ),
                ),
                Text(upvote.toString()),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.thumb_down,
                    color: Colors.grey[350],
                    size: 20,
                  ),
                ),
                Text(downvote.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
