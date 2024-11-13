import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/models/contractor.dart';

class ContractorRepository {
  const ContractorRepository(this._contractorDataRemoteProvider);

  final ContractorDataRemoteProvider _contractorDataRemoteProvider;
  Future<List<Contractor>> getContractors(String query) async {
    // API call to get contractors
    // Takes in a query string to filter the contractors
    // Returns a list of Contractors
    throw UnimplementedError();
  }
}
