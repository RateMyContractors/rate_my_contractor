/*
The data provider is responsible for providing raw data
-- exposses simple apis to perform crud operations (create data, read data, update data, delete data)
*/
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
        .select('*')
        .ilike('company_name', '%$query%');
        print(query);
        List<ContractorDto> contractorObjList = contractorJson.map<ContractorDto>((contractor) => ContractorDto.fromJson(contractor)).toList();
        return contractorObjList;
      } catch(error){
        return throw(Exception("data fetch failed: contractor table"));
      }
  }
  Future<List<LicenseDto>> getLicenses(String contractorId) async { //return licenses based on the existing contractor ids
      try{
        final licensesJson = await _supabaseClient
          .from('Licenses')
          .select('*')
          .eq('contractor_id', contractorId);
        
        List<LicenseDto> licenseObjList = licensesJson.map((license) => LicenseDto.fromJson(license)).toList();
        //licenseJson.map((json) => LicenseDto.fromJson(json))  ----> map() applies a specific transformation to each element in like a list || toList() gathers all of the transsformed elements and collects them into  a list
        //licenseJson.map((json) ----> for each json map in licenseJson (each user), map() applies the function (json) => License.fromJson(json)
        //the function LicenseDto.fromJson(json) convers each json map into a user object
        //License.fromJson(Licensejson) tells the JSON data to use the blueprint to make a License instance from it
        return licenseObjList;
      }catch(error){
        return throw(Exception("data fetch failed: licenses table"));
      }
    }
}