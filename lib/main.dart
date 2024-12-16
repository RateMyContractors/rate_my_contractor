import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
import 'package:rate_my_contractor/authentication/signup/screens/signup_page.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
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
  final userDataProvider = UserDataProvider(supabaseClient);
  final authRepository = AuthenticationRepository(userDataProvider);
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: repository),
      RepositoryProvider.value(value: authRepository),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
              create: (context) => SearchBloc(
                RepositoryProvider.of<ContractorRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => AuthenticationBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              )..add(
                  AuthenticationSubscriptionRequested(),
                ),
            ),
          ],
          child: const MyHomePage(title: 'Contractor Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String landingQuery = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image(
                  matchTextDirection: true,
                  image: AssetImage('assets/logo.png'),
                  height: 40,
                ),
              ),
              IconButton(
                icon: const Text('RateMyContractor'),
                onPressed: () {},
              ),
            ],
          ),
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return state.status != AuthenticationStatus.authenticated
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (_) => BlocProvider.value(
                                        value:
                                            BlocProvider.of<AuthenticationBloc>(
                                                context),
                                        child: const LoginPage(),
                                      )));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Hello User!',
                      );
              },
            ),
          ],
        ),
        body: Center(
          //block builder
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
                    fontSize: 25.0, color: Color.fromARGB(255, 255, 255, 255)),
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
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchTextUpdated(query: value));
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        var currBlocContext = context;
                        BlocProvider.of<SearchBloc>(currBlocContext)
                            .add(const SearchButtonPressed());
                        Navigator.push(
                          currBlocContext,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<SearchBloc>(
                                        currBlocContext),
                                    child: const ResultsPage(),
                                  )),
                        );
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
        ));
  }
}
