import 'package:flutter/material.dart';
import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    //required this.rating,
    // required this.totalRating,
    // required this.totalRatings,
    required this.entirerating,
    super.key,
  });
  //final double rating;
  // final List<double?> totalRating;
  // final int totalRatings;
  final List<ReviewsDto> entirerating;

  @override
  Widget build(BuildContext context) {
    //final avgRate = rating;
    final ratingCounts = <int, int>{for (var i = 1; i <= 5; i++) i: 0};
    // final totalRatingLength = totalRating.length;

    //rating - 2.8 inika is passing
    var totalRating =
        entirerating.map((x) => x.rating).toList(); //[ 3, 3, 2, 3, 3]
    final totalRatingLength = totalRating.length;

    double avgRate = totalRating.fold(0, (a, b) => a + b / totalRatingLength);
    avgRate = double.parse(avgRate.toStringAsFixed(1));

    for (final ratings in totalRating) {
      if (ratings != null) {
        final roundedRating = ratings.round();
        if (roundedRating >= 1 && roundedRating <= 5) {
          ratingCounts[roundedRating] = (ratingCounts[roundedRating] ?? 0) + 1;
        }
      }
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 175, 175, 175),
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Review Summary',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
              fontSize: 25,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (starIndex) {
                final starFill = avgRate - starIndex;
                if (starFill >= 1) {
                  return const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 25,
                  );
                } else if (starFill > 0) {
                  return const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                    size: 25,
                  );
                } else {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.grey,
                    size: 25,
                  );
                }
              }),
              const SizedBox(width: 10),
              Text(
                '$avgRate out of 5',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(5, (index) {
              final star = 5 - index;
              final count = ratingCounts[star] ?? 0;
              final percentage =
                  totalRatingLength > 0 ? count / totalRatingLength : 0.0;
              return Row(
                children: [
                  Text(
                    '$star ★',
                    style: const TextStyle(fontSize: 14),
                  ), // Star label
                  const SizedBox(width: 5),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: percentage, // Fill percentage (0.0 - 1.0)
                      backgroundColor: Colors.grey[300],
                      color: Colors.orange,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${(percentage * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 14),
                  ), // Count label
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
