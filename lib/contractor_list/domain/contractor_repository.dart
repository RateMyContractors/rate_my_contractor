/*
The repository layer is wrapped around one or more data providers with which the Bloc layer communicates with
*/
import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import '../data/models/contractor_dto.dart';
//have a try catch here and throw dont return an empty list
class ContractorRepository {
  const ContractorRepository(this._contractorDataRemoteProvider);
  //getting the data provider
  final ContractorDataRemoteProvider _contractorDataRemoteProvider;

  Future<List<Contractor>> getContractors(String query) async { 
    final List<ContractorDto> dataSetContractors = await _contractorDataRemoteProvider.getContractors(query); 
    final List<String> contractorIds = [];
    //List<Contractor> listOfContractors = [];
    
    for (var dsContractor in dataSetContractors) {
       contractorIds.add(dsContractor.id);
    }

    List<LicenseDto> dataSetLicenses = await _contractorDataRemoteProvider.getLicenses(contractorIds);

    List<Contractor> listOfContractors = dataSetContractors.map((contractor) { 
        List<LicenseDto> licensesMatch = dataSetLicenses 
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
          tags: licensesMatch.map((licenses) => licenses.licenseType).toList()
        );
      }
    ).toList();
  
    return listOfContractors;
  }
}
