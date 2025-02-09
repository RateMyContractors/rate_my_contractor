import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';

class ContractorCard extends StatelessWidget {
  const ContractorCard({
    required this.id,
    required this.companyName,
    required this.phone,
    required this.tags,
    super.key,
    this.ownerName,
    this.email,
    this.image,
    this.rating,
  });
  final String id;
  final String companyName;
  final String? ownerName;
  final String phone;
  final String? email;
  final String? image;
  final double? rating;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        var avgRate = 0.0;
        if (state.status == ReviewsStateStatus.success) {
          final entirerating = state.reviews;
          final totalRating = entirerating.map((x) => x.rating).toList();
          final totalRatingLength = totalRating.length;

          avgRate = totalRating.fold(0, (a, b) => a + b) / totalRatingLength;
          avgRate = double.parse(avgRate.toStringAsFixed(1));
          //print('avgRate$avgRate');
        }
        return Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 18),
              Text(
                companyName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Visibility(
                visible: ownerName != '',
                child: Text(
                  'Owner: $ownerName',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    avgRate.isNaN ? '0' : avgRate.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: phone != '',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 150, 150, 170),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            phone,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: email != '',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: Color.fromRGBO(150, 150, 170, 1),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            email ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 2000,
                height: 35,
                child: TextButton(
                  onPressed: () {
                    // Add your contact logic here
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    backgroundColor: const Color.fromARGB(255, 2, 2, 2),
                  ),
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(223, 221, 221, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
