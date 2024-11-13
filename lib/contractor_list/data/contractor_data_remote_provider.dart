import 'package:rate_my_contractor/contractor_list/data/models/contractor_dto.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractorDataRemoteProvider {
  const ContractorDataRemoteProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;
  Future<List<ContractorDto>> getContractors(String query) async {
    // API call to get contractors
    // Takes in a query string to filter the contractors
    // Returns a list of Contractors
    throw UnimplementedError();
  }

  Future<List<LicenseDto>> getLicenses(String query) async {
    // API call to get licenses
    // Takes in a query string to filter the licenses
    // Returns a list of Licenses
    throw UnimplementedError();
  }
}
