import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/data/models/rating_dto.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import '../data/models/contractor_dto.dart';

class ContractorRepository {
  const ContractorRepository(this._contractorDataRemoteProvider);
  final ContractorDataRemoteProvider _contractorDataRemoteProvider;

  Future<List<Contractor>> getContractors(String query) async {
    final List<ContractorDto> dataSetContractors =
        await _contractorDataRemoteProvider.getContractors(query);
    final List<String> contractorIds = [];

    for (var dsContractor in dataSetContractors) {
      contractorIds.add(dsContractor.id);
    }
    print(contractorIds);

    List<LicenseDto> dataSetLicenses =
        await _contractorDataRemoteProvider.getLicenses(contractorIds);

    List<RatingDto> dataSetRating =
        await _contractorDataRemoteProvider.getRating(contractorIds);

    List<Contractor> listOfContractors = dataSetContractors.map((contractor) {
      List<LicenseDto> licensesMatch = dataSetLicenses
          .where((license) => license.contractorId == contractor.id)
          .toList();

      List<RatingDto> ratingMatch =
          dataSetRating.where((rating) => rating.id == contractor.id).toList();

      List<double?> totalRatingList =
          ratingMatch.map((rating) => rating.rating).toList();

      print('Ratings for contractor $contractorIds: $totalRatingList');

      return Contractor(
          id: contractor.id,
          companyName: contractor.companyname,
          address: contractor.address,
          ownerName: contractor.owner,
          phone: contractor.phone,
          email: contractor.email,
          licenses: licensesMatch,
          totalRating: totalRatingList,
          rating: ratingMatch.isEmpty
              ? 0
              : double.parse((ratingMatch
                          .map((rating) => rating.rating)
                          .reduce((a, b) => a! + b!)! /
                      ratingMatch.length)
                  .toStringAsFixed(1)),
          tags: licensesMatch.map((licenses) => licenses.licenseType).toList());
    }).toList();

    return listOfContractors;
  }
}
