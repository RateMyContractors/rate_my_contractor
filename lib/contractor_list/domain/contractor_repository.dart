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
    final List<ContractorDto> dataSetContractors = await _contractorDataRemoteProvider.getContractors(query); //fetches raw data from provider and stores it in dataSetContractors
    final List<String> contractorIds = [];
    //List<Contractor> listOfContractors = [];
    
    for (var dsContractor in dataSetContractors) {
       contractorIds.add(dsContractor.id);
    }

    List<LicenseDto> dataSetLicenses = await _contractorDataRemoteProvider.getLicenses(contractorIds);

    List<Contractor> listOfContractors = dataSetContractors.map((contractor) { //iterate through all the contractors
        List<LicenseDto> licensesMatch = dataSetLicenses //iterate through all the licenses and return all the licenses that match contractor id
        .where((license) => license.contractorId == contractor.id)
        .toList();

        return Contractor( //return a contractor obj for each contractor in the contractor list
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
/*          listOfContractors.add(Contractor(
            id: dataSetContractors[i].id, 
            companyName: dataSetContractors[i].companyname, 
            address: dataSetContractors[i].address,
            ownerName: dataSetContractors[i].owner,
            phone: dataSetContractors[i].phone,
            email: dataSetContractors[i].email,
            licenses: dataSetLicenses,
            tags: dataSetLicenses.map((licenses) => licenses.licenseType).toList() //might not work
          )); */