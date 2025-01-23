import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
import 'package:rate_my_contractor/widgets/tag_widget.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 30),
                  const StarFilter(),
                  const SortBy(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: SearchBar(
                        hintText: 'Search',
                        onChanged: (value) {
                          context
                              .read<SearchBloc>()
                              .add(SearchTextUpdated(query: value));
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.status == SearchStateStatus.valid
                          ? const Color.fromARGB(255, 123, 127, 211)
                          : Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: state.status == SearchStateStatus.valid
                        ? () {
                            context
                                .read<SearchBloc>()
                                .add(const SearchButtonPressed());
                          }
                        : null,
                    child: const Text(
                      'Search', //Search button
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              Visibility(
                visible: state.status == SearchStateStatus.success,
                child: Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.contractors.length,
                    itemBuilder: (context, index) {
                      return _ProfileCard(contractor: state.contractors[index]);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: state.status == SearchStateStatus.failure,
                child: Expanded(
                  child: Container(
                    color: Colors.red,
                    constraints: const BoxConstraints.expand(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Search Failed',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(state.errormsg),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: state.status == SearchStateStatus.loading,
                child: Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 152, 148, 148),
                    constraints: const BoxConstraints.expand(),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20, // Adjust the size as needed
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StarFilter extends StatelessWidget {
  const StarFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Icon(Icons.filter_alt),
      items: const [
        DropdownMenuItem(value: 'Allstars', child: Text('All Ratings')),
        DropdownMenuItem(
          value: '1starts',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '2starts',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '3starts',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '4starts',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
            ],
          ),
        ),
        DropdownMenuItem(
          value: '5starts',
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
              Icon(Icons.star, color: Colors.orange, size: 20),
            ],
          ),
        ),
      ],
      onChanged: (value) => (),
    );
  }
}

class SortBy extends StatelessWidget {
  const SortBy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Icon(Icons.sort_rounded),
      items: const [
        DropdownMenuItem(value: 'asc', child: Text('Ascending (A-Z)')),
        DropdownMenuItem(value: 'des', child: Text('Descending (Z-A)')),
      ],
      onChanged: (value) => {
        if (value == 'asc')
          {
            context.read<SearchBloc>().add(const SearchSortPressed(sort: true)),
          }
        else if (value == 'des')
          {
            context
                .read<SearchBloc>()
                .add(const SearchSortPressed(sort: false)),
          },
      },
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.contractor,
  });
  final Contractor contractor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ReviewsBloc>(context)
            .add(ReviewsRequest(contractorId: contractor.id));
        Navigator.push<ContractorPage>(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<ReviewsBloc>(),
                ),
                BlocProvider.value(
                  value: context.read<AuthenticationBloc>(),
                ),
              ],
              child: ContractorPage(contractor: contractor),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 217, 202, 202),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 150,
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
                    Text(
                      contractor.companyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      contractor.ownerName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: contractor.tags.map((tag) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
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
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        contractor.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
