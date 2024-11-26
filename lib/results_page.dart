import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/error_search_page.dart';
import 'contractor_list/domain/models/contractor.dart';
import 'widgets/tag_widget.dart';


//first try to use bloc provider here 
class ResultsPage extends StatelessWidget{
  final List<Contractor> contractors;

  //do a bloc builder here to build the search results
//here we also replace the whole page with loading
//use contractors data to display it 
  const ResultsPage({super.key, required this.contractors}); 

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
      ),
      body: 
      BlocListener<SearchBloc, SearchState>(
        listener: (context, state){
          if (state is SearchFailure) {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => ErrorSearchPage(errormsg: state.errormsg))
            );
          }
        },
    
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state){
          // bool isButtonOn = false;
          // String validQuery = '';
          // if (state is SearchInvalid){
          //   isButtonOn = state.isButtonOn; 
          // } else if (state is SearchValid){
          //   validQuery = state.query;
          //   isButtonOn = state.isButtonOn;
          // } 
      return Column(
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
    );
       }
      
  )
      )
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
        // Navigator.push(
        //   //context,
        //   // MaterialPageRoute(
        //   //   builder: (context) => ContractorPage(contractor: contractor),
        //   //   ),
        //   );
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
                      Text(contractor.ownerName ?? '', //if no owner name found
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

// import 'package:flutter/material.dart';

// class ResultsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Results'),
//         backgroundColor: Colors.blue, // Customize as needed
//       ),
//       body: Center(
//         child: Text(
//           'Results will be displayed here!',
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.grey[600],
//           ),
//         ),
//       ),
//     );
//   }
// }
