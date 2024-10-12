import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchQuery = '';
  
  get child => null; //user input 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 234, 250),
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.end, 
            children:[
              const Padding(
              padding: EdgeInsets.only(top:15.0),
              child: Image(image: AssetImage('assets/logo.png'),
              ),
              ),
              IconButton(
              icon: const Text('RateMyContracter'),
              onPressed: () {},
              ), 
            ]
            ),
          ],
        ),

      
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Find who you need',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Fastest way to browse, review and see contracters in your area!',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 100, 100, 100)
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                      child: SearchBar(
                      hintText: 'Search by name, phone, or email',
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; //user input being assigned as recieved 
                          });
                          } ,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                         onPressed: (){
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(//go to other pg, find query
                      //       builder: (context) => ResultsPage(query: searchQuery),
                      //     ),
                      //   );
                       },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 123, 127, 211), // Change the button color here
                        minimumSize: const Size(50, 50), // Change the size of the button
                        padding: const EdgeInsets.all(16), // Adjust padding for size
                        //shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(12), // Rounded corners if needed
                      //),
                      ),
                      child: const Text(
                        'Search',    //Search button                
                        style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],  
              ),
            ),
          ],
        ),
      ),
    );
  }
}
