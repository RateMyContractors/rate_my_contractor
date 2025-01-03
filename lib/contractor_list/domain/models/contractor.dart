import 'package:equatable/equatable.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';

class Contractor extends Equatable {
  const Contractor({
    required this.id,
    required this.companyName,
    required this.address,
    required this.tags,
    required this.phone,
    required this.licenses,
    this.ownerName,
    this.image,
    this.rating = 0,
    this.email = 'email not provided',
    this.aboutUs,
  });

  /// Everything that a contractor DTO would have
  /// Plus the list of Licenses associated with that contractor
  final String id;
  final String companyName;
  final String address;
  final String? ownerName;
  final String? image;
  final double rating;
  final List<String> tags; //add to table?
  final String phone;
  final String? email;
  final String? aboutUs;
  final List<LicenseDto> licenses;

  @override
  List<Object?> get props => [
        id,
        companyName,
        ownerName,
        image,
        rating,
        tags,
        phone,
        email,
        aboutUs,
        licenses,
      ];
}
