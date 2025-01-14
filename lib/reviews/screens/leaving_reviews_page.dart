import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewFormPage extends StatelessWidget {
  const ReviewFormPage({super.key, required this.companyName});
  final String companyName;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment:
                            Alignment.centerLeft, // Align text to the left
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
                        alignment:
                            Alignment.centerLeft, // Align text to the left
                        child: Text(
                          "Overall Rating",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star_border, size: 30),
                        Icon(Icons.star_border, size: 30),
                        Icon(Icons.star_border, size: 30),
                        Icon(Icons.star_border, size: 30),
                        Icon(Icons.star_border, size: 30),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(height: 10),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment:
                            Alignment.centerLeft, // Align text to the left
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
                        alignment:
                            Alignment.centerLeft, // Align text to the left
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
                            onPressed: () {},
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Post'),
                          ),
                          const SizedBox(width: 8)
                        ])),
                  ],
                ))));
  }
}