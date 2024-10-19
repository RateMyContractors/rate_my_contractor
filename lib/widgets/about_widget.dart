import 'package:flutter/material.dart';
class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({
    super.key,
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About Us\n", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color.fromARGB(255, 255, 18, 227)
            )),
            Text("Hi, I'm John Davis, a home improvement expert with over 10 years of experience specializing in house painting and flooring repairs. Whether you're looking to refresh your home's interior with a fresh coat of paint or fix damaged flooring, I bring quality craftsmanship and attention to detail to every project. I’m committed to making your space look its best, and I work closely with clients to ensure they’re happy with the results. Reach out today for a free consultation!",
            style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}