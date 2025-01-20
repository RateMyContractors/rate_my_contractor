import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final int rating;
  final String comment;
  final String? image;
  final String date;

  ReviewCard({
    super.key,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    List<String> reviewImages = [
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
    ];
    return Container(
        //color: Colors.transparent,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          //border: Border.all(color: Colors.grey, width: 0.02)
        ),
        child: Align(
            alignment: Alignment.center,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  reviewerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                    fontSize: 14.0,
                  ),
                ),
              ]),
              const SizedBox(height: 5.0),
              Row(
                children: List.generate(
                  5,
                  (starIndex) => Icon(
                    Icons.star,
                    color: starIndex < rating ? Colors.orange : Colors.grey,
                    size: 18.0,
                  ),
                ),
              ),
              Text(
                'Reviewed on $date',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                  color: Color.fromARGB(255, 167, 160, 163),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                comment,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Row(children: [
                SizedBox(
                    height: 120.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: reviewImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(reviewImages[index]),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          );
                        }))
              ]),
              const SizedBox(height: 5.0),
              Row(children: [
                Icon(Icons.thumb_up, color: Colors.grey[350], size: 20.0),
                const SizedBox(width: 5.0),
                Icon(Icons.thumb_down, color: Colors.grey[350], size: 20.0),
              ])
            ])));
  }
}
