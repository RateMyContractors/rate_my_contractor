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
          border: Border.all(color: const Color(0xFFFF5C00)),
          borderRadius: const BorderRadius.all(Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Us\n", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color.fromARGB(255, 255, 18, 227)
            )),
            Text(
              aboutUs,
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}