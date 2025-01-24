import 'package:flutter/material.dart';


class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({
    super.key,
    required this.aboutUs,
  });
  final String aboutUs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 1200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Us\n",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0))),
          Text(aboutUs, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

