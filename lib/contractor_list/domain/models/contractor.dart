//done
import 'package:equatable/equatable.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import '../../data/models/contractor_dto.dart';
//add equatable here; dont want it to rebuild everytime if we dont have to
//get rid of previous ones
//make sure this domain model cates to the feature, try to make it as similar to the previous contractor file
class Contractor extends Equatable  {
  /// Everything that a contractor DTO would have
  /// Plus the list of Licenses associated with that contractor
  final String id;
  final String companyName;
  final String address;
  final String? ownerName;
  final String? image;
  final double? rating;
  final List<String>? tags; //add to table?
  final String phone;
  final String? email;
  final String? aboutUs;
  final List<LicenseDto> licenses;

  const Contractor({
    required this.id,
    required this.companyName,
    required this.address,
    this.ownerName,
    this.image,
    this.rating,
    this.tags,
    required this.phone,
    this.email,
    this.aboutUs,
    required this.licenses
  });

  @override
  List<Object?> get props => [id, companyName, ownerName, image, rating, tags, phone, email, aboutUs, licenses];
}