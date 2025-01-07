import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewFormPage extends StatelessWidget {
  const ReviewFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
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
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Column(
                  children: [
                    Text("Create Review"),
                    Text("Overall Rating"),
                    Text("Add a written Review"),
                    Text("Add a Photo"),
                  ],
                ))));
  }
}
