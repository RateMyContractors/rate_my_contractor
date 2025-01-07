import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final double rating;
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
    return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 201, 186, 225),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey, width: 1.0),
            ), 
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                  children: [
                    CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 18.0),               
                  Text(
                    reviewerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      fontSize: 15.0,
                    ),
                  ),]
                  ),
                  const SizedBox(height:10.0),       
                  Row(
                      children: List.generate(
                          5,
                          (starIndex) => Icon(
                            Icons.star,
                            color: starIndex < rating
                                ? Colors.orange
                                : Colors.grey,
                            size: 20.0,
                          ),
                        ),
                      ),
                  Text(
                    'Reviewed on $date',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'TimesNewRoman',
                      fontSize: 15.0,
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
                ]
        ) )
    );
  }
}