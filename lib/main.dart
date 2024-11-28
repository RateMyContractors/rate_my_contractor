import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/error_search_page.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';



void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  final supabaseClient = SupabaseClient(
    dotenv.env['SUPABASE_URL']!,
    dotenv.env['SUPABASE_KEY']!,
  );
  final remoteProvider = ContractorDataRemoteProvider(supabaseClient);
  final repository = ContractorRepository(remoteProvider);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});
  final ContractorRepository repository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contractor Webapp',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 228, 245),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchBloc(repository),
            child: BlocListener<SearchBloc, SearchState> (
              listener: (context, SearchState) {},)
          ),
        ],
      child: const MyHomePage(title: 'Contractor Home Page'),
      )
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
              icon: const Text('RateMyContractor'),
              onPressed: () {},
            ),
          ]),
        ],
      ),
      body: 
      BlocListener<SearchBloc, SearchState>(
        listener: (context, state){
          var currBlocContext = context;
          if (state.status == SearchStateStatus.success) {
            Navigator.push(
              currBlocContext,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<SearchBloc>(currBlocContext),
                                    child: ResultsPage(
                                      contractors: state.contractors
                                    ),
                                  )
                                ),
            );
          } else if (state.status == SearchStateStatus.loading) {
            // isButtonOn = state.isButtonOn;
            const CircularProgressIndicator();
          } else if (state.status == SearchStateStatus.failure) {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => ErrorSearchPage(errormsg: state.errormsg))
            );
          }
        },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state){
          // //bool isButtonOn = false;
          //String validQuery = '';
          // // if (state is SearchInvalid){
          // //   isButtonOn = state.isButtonOn; 
          // // } else if (state is SearchValid){
          // //   validQuery = state.query;
          // //   isButtonOn = state.isButtonOn;
          // // } 
          return Center( //block builder
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
                  'Fastest way to browse, review and see contractors in your area!',
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
                            context.read<SearchBloc>().add(SearchTextUpdated(query: value));
                            //setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: state.isButtonOn ? () { //just need state.isButtonOn
                        context.read<SearchBloc>().add(SearchButtonPressed(query: state.query));
                        //print('Search text updated: $state.query'); 
                        }
                        : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:state.isButtonOn
                              //const Color.fromARGB(255, 123, 127, 211),
                              ? const Color.fromARGB(255, 123, 127, 211)
                              : Colors.grey,
                          minimumSize: const Size(50, 50),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: state.status == SearchStateStatus.loading
                          ? const SizedBox(
                              width: 20, // Adjust the size as needed
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2.0,
                              ),
                            )
                          : const Text(
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
          );
        }
       )
      )
    );
  }
}