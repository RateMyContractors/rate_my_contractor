import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final List<int> rating;

  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    int totalRate = 0;
    for (int rate in rating) {
      totalRate += rate;
    }
    double avgRate = totalRate / rating.length;
    String avgRatetext = avgRate.toStringAsFixed(1);
    Map<int, int> ratingCounts = {for (var i = 1; i <= 5; i++) i: 0};
    for (int ratings in rating) {
      ratingCounts[ratings] = (ratingCounts[ratings] ?? 0) + 1;
    }
    int totalRatings = rating.length; //add text for total reviews
    print(ratingCounts);
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        height: 250,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 175, 175, 175),
              blurRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(children: [
          const Text(
            'Review Summary',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto',
              fontSize: 25.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (starIndex) {
                double starFill = avgRate - starIndex;
                if (starFill >= 1) {
                  return const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 25.0,
                  );
                } else if (starFill > 0) {
                  return const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                    size: 25.0,
                  );
                } else {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.grey,
                    size: 25.0,
                  );
                }
              }),
              const SizedBox(width: 10.0),
              Text(
                '${avgRatetext} out of 5',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(5, (index) {
              int star = 5 - index; // Start from 5 stars
              int count = ratingCounts[star] ?? 0; // Votes for this star
              double percentage = totalRatings > 0 ? count / totalRatings : 0.0;
              return Row(
                children: [
                  Text('$star ★',
                      style: const TextStyle(fontSize: 14.0)), // Star label
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10.0),
                      value: percentage, // Fill percentage (0.0 - 1.0)
                      backgroundColor: Colors.grey[300],
                      color: Colors.orange,
                      minHeight: 10.0,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Text('${percentage.toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 14.0)), // Count label
                ],
              );
            }),
          )
        ]));
  }
}
