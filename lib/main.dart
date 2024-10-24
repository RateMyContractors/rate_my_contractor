import 'package:flutter/material.dart';
import 'package:rate_my_contractor/results_page.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 77, 117, 79),

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contractor Home Page'), 
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                          setState(() {});
                          } ,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                         onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ResultsPage())
                          );
                         },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 123, 127, 211), 
                        minimumSize: const Size(50, 50), 
                        padding: const EdgeInsets.all(16), 
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
