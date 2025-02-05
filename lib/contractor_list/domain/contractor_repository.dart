import 'package:rate_my_contractor/contractor_list/data/contractor_data_remote_provider.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';

class ContractorRepository {
  const ContractorRepository(this._contractorDataRemoteProvider);
  final ContractorDataRemoteProvider _contractorDataRemoteProvider;

  Future<List<Contractor>> getContractors(
    String query, {
    required bool sortcontractors,
  }) async {
    final dataSetContractors = await _contractorDataRemoteProvider
        .getContractors(query, sort: sortcontractors);
    final contractorIds = <String>[];

    for (final dsContractor in dataSetContractors) {
      contractorIds.add(dsContractor.id);
    }

    final dataSetLicenses =
        await _contractorDataRemoteProvider.getLicenses(contractorIds);

    final dataSetRating =
        await _contractorDataRemoteProvider.getRating(contractorIds);

    final listOfContractors = dataSetContractors.map((contractor) {
      final licensesMatch = dataSetLicenses
          .where((license) => license.contractorId == contractor.id)
          .toList();

      final ratingMatch =
          dataSetRating.where((rating) => rating.id == contractor.id).toList();

      final totalRatingList =
          ratingMatch.map((rating) => rating.rating).toList();

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
            : double.parse(
                (ratingMatch
                            .map((rating) => rating.rating)
                            .reduce((a, b) => a! + b!)! /
                        ratingMatch.length)
                    .toStringAsFixed(1),
              ),
        tags: licensesMatch.map((licenses) => licenses.licenseType).toList(),
      );
    }).toList();

    return listOfContractors;
  }
}
