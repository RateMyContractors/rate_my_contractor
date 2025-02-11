import 'package:rate_my_contractor/contractor_list/data/models/contractor_dto.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/data/models/rating_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractorDataRemoteProvider {
  const ContractorDataRemoteProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;
  Future<List<ContractorDto>> getContractors(
    String query, {
    required bool sort,
  }) async {
    try {
      final contractorJson = await _supabaseClient
          .from('Contractors') // your table name in Supabase
          .select() //.ilike('company_name', '%$query%');
          .or('company_name.ilike.%$query%,'
              'address.ilike.%$query%,'
              'phone.ilike.%$query%,'
              'owner.ilike.%$query%,'
              'phone.ilike.%$query%')
          .order('company_name', ascending: sort);

      final contractorObjList = contractorJson
          .map<ContractorDto>(
            ContractorDto.fromJson,
          )
          .toList();
      return contractorObjList;
    } on Exception catch (error) {
      return throw Exception('data fetch failed: contractor table$error');
    }
  }

  Future<List<LicenseDto>> getLicenses(List<String> contractorIds) async {
    try {
      final licensesJson = await _supabaseClient
          .from('Licenses')
          .select()
          .inFilter('contractor_id', contractorIds);

      final licenseObjList = licensesJson.map(LicenseDto.fromJson).toList();
      return licenseObjList;
    } on Exception catch (error) {
      return throw Exception('data fetch failed: licenses table$error');
    }
  }

  Future<List<RatingDto>> getRating(List<String> contractorIds) async {
    try {
      final ratingsJson = await _supabaseClient
          .from('Reviews')
          .select('contractor_id, rating')
          .inFilter('contractor_id', contractorIds);
      final ratingObjList = ratingsJson.map(RatingDto.fromJson).toList();

      return ratingObjList;
    } on Exception catch (error) {
      return throw Exception('data fetch failed: Ratings table$error');
    }
  }
}
