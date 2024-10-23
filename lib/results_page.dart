import 'package:flutter/material.dart'; 
import 'widgets/tag_widget.dart';
import 'models/contractor.dart';
import 'contractor_page.dart';

List <Contractor> contractors = [
  const Contractor (
    id: 1,
    companyName: "Smith Plumbing Co.",
    ownerName: "John Smith",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.5,
    tags: ["Plumbing", "Emergency Repairs", "Installation"],
    phone: '+1 (631)859-4514', 
    email: 'john@smithshomeservices.com',
    aboutUs: 'Hi, I\'m John Smith, a home improvement expert with over 10 years of experience specializing in house painting and flooring repairs. Whether you\'re looking to refresh your home\'s interior with a fresh coat of paint or fix damaged flooring, I bring quality craftsmanship and attention to detail to every project. I’m committed to making your space look its best, and I work closely with clients to ensure they’re happy with the results. Reach out today for a free consultation!',
    ),
  const Contractor(
    id: 2,
    companyName: "HEHEHE",
    ownerName: "Jane Doe",
    image: "/placeholder.svg?height=100&width=100",
    rating: 5,
    tags: ["Electrical", "Wiring", "Lighting"],
    phone: '123', email: '123',
    aboutUs: 'Hi, I\'m Jane Doe, a home improvement expert with over 10 years of experience specializing in house painting and flooring repairs. Whether you\'re looking to refresh your home\'s interior with a fresh coat of paint or fix damaged flooring, I bring quality craftsmanship and attention to detail to every project. I’m committed to making your space look its best, and I work closely with clients to ensure they’re happy with the results. Reach out today for a free consultation!',
  ),
  const Contractor(
    id: 3,
    companyName: "Green Landscaping",
    ownerName: "HEHEHEH",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4,
    tags: ["Landscaping", "Lawn Care", "Tree Trimming"],
    phone: '', email: '',
    aboutUs: 'blah blah blah',
  ),
  const Contractor(
    id: 4,
    companyName: "Handy Home Repairs",
    ownerName: "Mike Johnson",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.8,
    tags: ["General Repairs", "Carpentry", "Painting"],
    phone: '', email: '',
    aboutUs: 'blah blah blah',
  ),
  const Contractor(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
    phone: '', email: '',
    aboutUs: 'blah blah blah',
  ),
  const Contractor(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
    phone: '', email: '',
    aboutUs: 'blah blah blah',
  ),
];


class ResultsPage extends StatelessWidget{  
  const ResultsPage({super.key}); 

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: SearchBar(
            hintText: 'Search',
              onChanged: (value) {},
            ),
          ),
          Expanded(
          child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: contractors.length,
            itemBuilder: (context,index){
              return _ProfileCard(contractor: contractors[index]);
            },
          ),
         ),
         const Row(children: [
          Text("End of Results")
         ],)
      ],
    ),
  );
}
}

class _ProfileCard extends StatelessWidget {
  final Contractor contractor;

  const _ProfileCard({
    super.key,
    required this.contractor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractorPage(contractor: contractor),
            ),
          );
      }, 
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 217, 202, 202),
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 150.0,
            child: Row(
              children: [
                const SizedBox(width: 30), 
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 195, 187, 187),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30), 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(contractor.companyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                      Text(contractor.ownerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey,
                            )),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                        children: contractor.tags.map((tag) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OvalTags(tag: tag),
                          );
                        }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(), 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color.fromARGB(255, 255, 222, 59)),
                        Text(
                          contractor.rating.toString(),
                          style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20.0,
                         )
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(width:30)
              ],
            ),
          ),
        ),
       );
      }
    }

