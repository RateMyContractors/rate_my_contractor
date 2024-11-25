import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorSearchPage extends StatelessWidget {
  final String errormsg;
  const ErrorSearchPage({super.key, required this.errormsg});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //consist of the visible components of the app, has properties body(center, child:text) and the app bar 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(errormsg, 
            style: const TextStyle(color: Color.fromARGB(255, 81, 24, 24)),),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Text("Try again",
                style: TextStyle(color: Color.fromARGB(255, 52, 132, 244)),
              ),
            )
          ]
        )
      )
    );
  }
}