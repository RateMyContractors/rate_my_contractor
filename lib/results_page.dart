import 'package:flutter/material.dart';
import 'package:rate_my_contractor/contractor_page.dart'; //pre-designed widgets and tools are being imported

//Contractor List - sample input data
List <Widget> contractor = [
  const ProfileCard(
    id: 1,
    companyName: "Smith Plumbing Co.",
    ownerName: "John Smith",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.5,
    tags: ["Plumbing", "Emergency Repairs", "Installation"],
    phone: '+1 (631)859-4514', 
    email: 'john@smithshomeservices.com',
  ),
  const ProfileCard(
    id: 2,
    companyName: "HEHEHE",
    ownerName: "Jane Doe",
    image: "/placeholder.svg?height=100&width=100",
    rating: 5,
    tags: ["Electrical", "Wiring", "Lighting"],
    phone: '123', email: '123',
  ),
  const ProfileCard(
    id: 3,
    companyName: "Green Landscaping",
    ownerName: "HEHEHEH",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4,
    tags: ["Landscaping", "Lawn Care", "Tree Trimming"],
    phone: '', email: '',
  ),
  const ProfileCard(
    id: 4,
    companyName: "Handy Home Repairs",
    ownerName: "Mike Johnson",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.8,
    tags: ["General Repairs", "Carpentry", "Painting"],
    phone: '', email: '',
  ),
  const ProfileCard(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
    phone: '', email: '',
  ),
  const ProfileCard(
    id: 5,
    companyName: "Cool Air HVAC",
    ownerName: "Sarah Brown",
    image: "/placeholder.svg?height=100&width=100",
    rating: 4.7,
    tags: ["HVAC", "Air Conditioning", "Heating"],
    phone: '', email: '',
  ),
];


class ResultsPage extends StatelessWidget{  //defined class that extends statefulwidget (means app changes over time)
  const ResultsPage({super.key}); //constructor for creating the class (when creating a new object from the class the cunstroctor is automatically called to initialize it in which the constructor is passing information (like the key) when creating widgets)
  //the super key is a key used by flutter to keep track of widgets in which super refers to the parent class in which it is passing the key of the constructor of the stateless widget. Key is being used to uniquely identify widgets
  @override
  Widget build(BuildContext context) { //build function is used to describe how the UI should look like, BuildContext gives info about the location of the widget in the app tree
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
            itemCount: contractor.length,
            itemBuilder: (context,index){
              return contractor[index];
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

//creating a class for the tags
//this can be added later: this widget accepts text and color, in which depending on the tag, the color of the oval should be different
class OvalTags extends StatelessWidget {
  final String tag;

  const OvalTags({
    super.key,
    required this.tag
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(96, 198, 193, 201),
        borderRadius: BorderRadius.all(Radius.elliptical(100, 100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          tag,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
          )

        ))
    );
  }
}

/*
    Contractor(
      id: 1,
      companyName: "Smith Plumbing Co.",
      ownerName: "John Smith",
      image: "/placeholder.svg?height=100&width=100",
      rating: 4.5,
      tags: ["Plumbing", "Emergency Repairs", "Installation"],
    ),
*/

class ProfileCard extends StatelessWidget {
  final int id;
  final String companyName;
  final String ownerName;
  final String phone;
  final String email;
  final String image;
  final double rating;
  final List<String> tags;
  
  const ProfileCard({
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
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
        // Navigate to the ContractorDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractorPage(contractor: ProfileCard(       
            id: id,
            companyName: companyName,
            ownerName: ownerName,
            phone: phone,
            email: email,
            image: image,
            rating: rating,
            tags: tags,
            )
            ),
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
                const SizedBox(width: 30), //controls spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(companyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                      Text(ownerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey,
                            )),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                        children: tags.map((tag) {
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
                          rating.toString(),
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

