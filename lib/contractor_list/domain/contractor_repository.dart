import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';

//have a try catch here and throw dont return an empty list
class ContractorRepository {
  const ContractorRepository(this._contractorDataRemoteProvider);
  //getting the data provider
  final ContractorDataRemoteProvider _contractorDataRemoteProvider;

  Future<List<Contractor>> getContractors(String query) async {
    final dataSetContractors =
        await _contractorDataRemoteProvider.getContractors(query);
    final contractorIds = <String>[];
    //List<Contractor> listOfContractors = [];

    for (final dsContractor in dataSetContractors) {
      contractorIds.add(dsContractor.id);
    }

    final dataSetLicenses =
        await _contractorDataRemoteProvider.getLicenses(contractorIds);

    final listOfContractors = dataSetContractors.map((contractor) {
      final licensesMatch = dataSetLicenses
          .where((license) => license.contractorId == contractor.id)
          .toList();

      return Contractor(
        id: contractor.id,
        companyName: contractor.companyname,
        address: contractor.address,
        ownerName: contractor.owner,
        phone: contractor.phone,
        email: contractor.email,
        licenses: licensesMatch,
        tags: licensesMatch.map((licenses) => licenses.licenseType).toList(),
      );
    }).toList();

    return listOfContractors;
  }
}
