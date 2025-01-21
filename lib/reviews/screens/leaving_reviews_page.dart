import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';

class ReviewFormPage extends StatelessWidget {
  const ReviewFormPage(
      {super.key, required this.companyName, required this.contractorid});
  final String companyName;
  final String contractorid;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocBuilder<ReviewsBloc, ReviewsState>(builder: (context, state) {
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
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              //width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Text("Create Review",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        companyName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 139, 63, 177)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 10),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        "Overall Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const StarSytem(),
                  const SizedBox(height: 15),
                  const Divider(height: 10),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        "Add a written review",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'What do you think of the company?'),
                      validator: (String? value) {
                        if (value != null || value!.isEmpty) {
                          return 'Response cannot be left empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 10),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        "Add a photo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: size.width < 800
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                Column(children: [
                                  Icon(
                                    Icons.upload,
                                    color: Color.fromARGB(255, 163, 64, 170),
                                    size: 50.0,
                                    semanticLabel: 'Insert Photo',
                                  ),
                                  Text('Upload')
                                ]),
                                Column(children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Color.fromARGB(255, 163, 64, 170),
                                    size: 50.0,
                                    semanticLabel: 'take_a_picture',
                                  ),
                                  Text('Take a picture')
                                ]),
                              ])
                        : const Column(children: [
                            Icon(
                              Icons.upload,
                              color: Color.fromARGB(255, 163, 64, 170),
                              size: 50.0,
                              semanticLabel: 'Insert Photo',
                            ),
                            Text('Upload')
                          ]),
                  ),
                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 163, 64, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ReviewsBloc>(context).add(
                              ReviewsFormButtonPressed(
                                  contractorid: contractorid,
                                  reviewerid:
                                      '3c335755-9c36-4f66-9d53-fbd1ef2b13ed',
                                  rating: 4,
                                  comment: 'testing reviews form',
                                  upvote: 1,
                                  downvote: 1),
                            );
                          },
                          child: const Text('Post'),
                        ),
                        const SizedBox(width: 8)
                      ])),
                ],
              )));
    }));
  }
}

class StarSytem extends StatelessWidget {
  const StarSytem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          hoverColor: const Color.fromARGB(255, 255, 230, 0),
          icon: const Icon(Icons.star_border),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 1));
          },
        ),
        IconButton(
          hoverColor: const Color.fromARGB(255, 255, 230, 0),
          icon: const Icon(Icons.star_border),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 2));
          },
        ),
        IconButton(
          hoverColor: const Color.fromARGB(255, 255, 230, 0),
          icon: const Icon(Icons.star_border),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 3));
          },
        ),
        IconButton(
          hoverColor: const Color.fromARGB(255, 255, 230, 0),
          icon: const Icon(Icons.star_border),
          onPressed: () {
            context
                .read<ReviewsBloc>()
                .add(const ReviewsStarsPressed(starRating: 4));
          },
        ),
        IconButton(
          hoverColor: const Color.fromARGB(255, 255, 230, 0),
          icon: const Icon(Icons.star_border),
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
