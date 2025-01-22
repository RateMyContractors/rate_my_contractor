import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/data/user_data_provider.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:rate_my_contractor/reviews/data/reviews_data_provider.dart';
import 'package:rate_my_contractor/reviews/domain/reviews_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabaseClient = SupabaseClient(
    const String.fromEnvironment('SUPABASE_URL'),
    const String.fromEnvironment('SUPABASE_KEY'),
    authOptions: const AuthClientOptions(authFlowType: AuthFlowType.implicit),
  );
  final remoteProvider = ContractorDataRemoteProvider(supabaseClient);
  final repository = ContractorRepository(remoteProvider);
  final userDataProvider = UserDataProvider(supabaseClient);
  final authRepository = AuthenticationRepository(userDataProvider);
  final reviewsDataProvider = ReviewsDataProvider(supabaseClient);
  final reviewsRepository = ReviewsRepository(reviewsDataProvider);
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: repository),
      RepositoryProvider.value(value: authRepository),
      RepositoryProvider.value(value: reviewsRepository),
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
              create: (context) => ReviewsBloc(
                RepositoryProvider.of<ReviewsRepository>(context),
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
          // child: const ReviewFormPage(
          //   companyName: 'Bridget co.',
          // ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});
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
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
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
              final username = state.user?.firstname ?? 'Guest';
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: state.status != AuthenticationStatus.authenticated
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<AuthenticationBloc>(
                                      context,
                                    ),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<SearchBloc>(context),
                                  ),
                                ],
                                child: const LoginPage(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Hello $username',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
              );
            },
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
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Fastest way to browse, review and see contractors in your area!',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        MaterialPageRoute<ResultsPage>(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<SearchBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<ReviewsBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<AuthenticationBloc>(),
                              ),
                            ],
                            child: const ResultsPage(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 123, 127, 211),
                      minimumSize: const Size(50, 50),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
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
