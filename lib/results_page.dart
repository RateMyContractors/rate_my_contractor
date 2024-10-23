import 'package:flutter/material.dart'; 
import 'widgets/tag_widget.dart';
import 'models/contractor.dart';

List <Contractor> contractors = [
  const Contractor (
    id: 1,
    companyName: "Smith Plumbing Co.",
    ownerName: "John Smith",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.5,
    tags: ["Plumbing", "Emergency Repairs", "Installation"],
  ),
  const Contractor(
    id: 2,
    companyName: "HEHEHE",
    ownerName: "Jane Doe",
    image: "/placeholder.svg?height=100&width=100",
    rating: 5,
    tags: ["Electrical", "Wiring", "Lighting"],
  ),
  const Contractor(
    id: 3,
    companyName: "Green Landscaping",
    ownerName: "HEHEHEH",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4,
    tags: ["Landscaping", "Lawn Care", "Tree Trimming"],
  ),
  const Contractor(
    id: 4,
    companyName: "Handy Home Repairs",
    ownerName: "Mike Johnson",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.8,
    tags: ["General Repairs", "Carpentry", "Painting"],
  ),
  const Contractor(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
  ),
  const Contractor(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
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
    return Container(
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
                const SizedBox(width: 30), //controls spacing
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
        );
      }
    }

