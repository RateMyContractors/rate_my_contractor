import 'package:flutter/material.dart';
import 'widgets/about_widget.dart';
import 'widgets/portfolio_widget.dart';


class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(0, 255, 255, 255),
            margin: const EdgeInsets.only(right: 120, left:120, top: 20),
            child: const Column(
              children: [
                AboutUsWidget(),
                SizedBox(height:20),
                PortfolioWidget(),
              ],
            ),
          ),
        ),
    );
  }
}