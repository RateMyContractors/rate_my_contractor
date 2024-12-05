import 'package:flutter/material.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> portfolioimages = [
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
      'assets/samplepictures/fix1.jpg',
      'assets/samplepictures/fix2.jpg',
      'assets/samplepictures/fix3.jpg',
    ];
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Portfolio\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromARGB(255, 0, 0, 0),
              )),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount:
                portfolioimages.length, //number of items in portfolioimages
            itemBuilder: (context, index) {
              return Image.asset(portfolioimages[index], fit: BoxFit.cover);
            },
          )
        ]));
  }
}
