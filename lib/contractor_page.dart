import 'package:flutter/material.dart';
import 'package:rate_my_contractor/results_page.dart';


List <ContractorCard> contractor = [
  const ContractorCard(
    id: 1,
    companyName: "Smith Plumbing Co.",
    ownerName: "John Smith",
    phone: "+1 (631)859-4514",
    email: "john@smithshomeservices.com",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.5,
    tags: ["Plumbing", "Emergency Repairs", "Installation"],
  ),
];

class ContractorPage extends StatelessWidget{
  const ContractorPage({super.key , required Widget contractor});
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar : AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: contractor.length,
                itemBuilder: (context, index) {
                  // Directly use the contractor list
                  return contractor[index];
                },
              ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("End of Page"),
          ),
        ],
      )
    );
  }
}

class ContractorCard extends StatelessWidget{
  final int id;
  final String companyName;
  final String ownerName;
  final String phone;
  final String email;
  final String image;
  final double rating;
  final List<String> tags;

  const ContractorCard({
    super.key,
    required this.id,
    required this.companyName,
    required this.ownerName,
    required this.phone,
    required this.email,
    required this.image,
    required this.rating,
    required this.tags,
  });
  
  @override
  
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(height: 18.0),
                Text(
                  companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "Owner: $ownerName",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20.0),
                const SizedBox(width: 5.0),
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10.0),
          Align(
          alignment: Alignment.centerLeft, 
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Row(
                      children: [
                          const Icon(Icons.phone, color: Color.fromARGB(255, 150, 150, 170), size: 20.0),
                          const SizedBox(width:8.0),
                          Text(
                              phone,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.left,
                            ),
                      ],
                    ),
                    const SizedBox(height:8.0),
                    Row(
                    children: [
                          const Icon(Icons.mail, color: Color.fromRGBO(150, 150, 170, 1), size: 20.0),
                          const SizedBox(width:8.0),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft, 
                child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: tags.map((tag) {
                      return Chip(
                        label: Text(tag,
                        style: const TextStyle(
                          fontSize: 14.0,
                        )),
                        backgroundColor: Colors.grey[200],
                      );
                    }).toList(),
                  ),
            ),
          
          const SizedBox(height: 16.0), // Spacing before the Contact button
          SizedBox(  
            width:2000.0,
            height: 35.0,
            child: TextButton(
              onPressed: () {
              // Add your contact logic here
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              backgroundColor: const Color.fromARGB(255, 2, 2, 2), // Button background color
            ),
            child: const Text(
              'Contact',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(223, 221, 221, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );  
  }
}
  
