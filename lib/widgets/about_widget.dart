import 'package:flutter/material.dart';
class AboutUsWidget extends StatelessWidget {
  final String aboutUs;
  const AboutUsWidget({
    super.key, 
    required this.aboutUs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Us\n", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color.fromARGB(255, 0, 0, 0)
            )),
            Text(
              aboutUs,
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}