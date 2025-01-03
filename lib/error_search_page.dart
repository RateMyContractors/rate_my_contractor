import 'package:flutter/material.dart';

class ErrorSearchPage extends StatelessWidget {
  const ErrorSearchPage({required this.errormsg, super.key});
  final String errormsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errormsg,
              style: const TextStyle(color: Color.fromARGB(255, 81, 24, 24)),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Try again',
                style: TextStyle(color: Color.fromARGB(255, 52, 132, 244)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
