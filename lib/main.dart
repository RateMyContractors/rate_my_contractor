import 'package:flutter/material.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contractor Webapp',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 228, 245),
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
  final _future = Supabase.instance.client.from('Contractors').select('*');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          print('Here is a snapshot');
          if (snapshot.hasData) {
            print(snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          } else {
            print('No error');
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              actions: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  IconButton(
                    icon: const Text('RateMyContracter'),
                    onPressed: () {},
                  ),
                ]),
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
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Fastest way to browse, review and see contracters in your area!',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
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
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ResultsPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 123, 127, 211),
                            minimumSize: const Size(50, 50),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Text(
                            'Search', //Search button
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
