import 'package:flutter/material.dart';

class OvalTags extends StatelessWidget {
  const OvalTags({
    required this.tag,
    super.key,
  });
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(96, 198, 193, 201),
        borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          tag,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
