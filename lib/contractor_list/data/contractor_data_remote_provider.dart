import 'package:rate_my_contractor/contractor_list/data/models/contractor_dto.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractorDataRemoteProvider {

  const ContractorDataRemoteProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;
  Future<List<ContractorDto>> getContractors(String query) async {
      //String query
      try{
        final contractorJson = await _supabaseClient
        .from('Contractors')  // your table name in Supabase
        .select('*')        //.ilike('company_name', '%$query%');
        .or('company_name.ilike.%$query%,address.ilike.%$query%,phone.ilike.%$query%,owner.ilike.%$query%,phone.ilike.%$query%'); //not sure what would happen if we added email or owner since we have them all in NUll in our DB
        print(query);
        List<ContractorDto> contractorObjList = contractorJson.map<ContractorDto>((contractor) => ContractorDto.fromJson(contractor)).toList();
        return contractorObjList;
      } catch(error){
        return throw(Exception("data fetch failed: contractor table"));
      }
  }
  
  Future<List<LicenseDto>> getLicenses(List<String> contractorIds) async {
     try{
       final licensesJson = await _supabaseClient
         .from('Licenses')
         .select('*')
         .inFilter('contractor_id', contractorIds);

        List<LicenseDto> licenseObjList = licensesJson.map((license) => LicenseDto.fromJson(license)).toList();
        return licenseObjList;

      } catch(error){
       return throw(Exception("data fetch failed: licenses table"));
     }
   }
}