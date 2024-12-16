import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
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
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(12)),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text('Create your account to get started'),
                  Padding(padding: EdgeInsets.all(12)),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'FirstName', border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'LastName', border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Re-enter Password',
                        border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.all(12)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 181, 113, 192),
                      ),
                      onPressed: () {},
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 243, 243)))),
                ],
              ))),
    ));
  }
}
