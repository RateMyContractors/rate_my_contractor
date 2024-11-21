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
    //final List<LicenseDto> dataSetLicenses = await _contractorDataRemoteProvider.getLicenses(query); //get a set of contractor ids from the first data set 
    List<Contractor> listOfContractors = [];

    for (int i = 0; i < dataSetContractors.length; i++){ //get all licenses that match the set of contractors
      final List<LicenseDto> dataSetLicenses = await _contractorDataRemoteProvider.getLicenses(dataSetContractors[i].id);
      listOfContractors.add(Contractor(
        id: dataSetContractors[i].id, 
        companyName: dataSetContractors[i].companyname, 
        address: dataSetContractors[i].address,
        ownerName: dataSetContractors[i].owner,
        phone: dataSetContractors[i].phone,
        email: dataSetContractors[i].email,
        licenses: dataSetLicenses
      ));
    }
    return listOfContractors;
  }
}