
class LicenseDto { 
  final String licenseNumber;
  final String licenseType;
  final String town;
  final String id;
  final String licenseExpiration;
  final String? insuranceExpiration;
  final String isActive; //with the ? it allows nulls values for the attributes
  final String contractorId;
  
  const LicenseDto({ 
    required this.licenseNumber,
    required this.licenseType,
    required this.town,
    required this.id,
    required this.licenseExpiration,
    this.insuranceExpiration,
    required this.isActive,
    required this.contractorId
  });
  factory LicenseDto.fromJson(Map<String,dynamic> json)  {
    return LicenseDto(
      licenseNumber: json['license_number'] , 
      licenseType: json['license_type'], 
      town: json['town'], 
      id: json['id']?? '', 
      licenseExpiration: json['license_expiration'], 
      insuranceExpiration: json['insurance_expiration'], 
      isActive: json['is_active'].toString(), 
      contractorId: json['contractor_id'],
    );
  }

  @override
  String toString() => 
      'ContractorDto(id: $id, licenseNumber: $licenseNumber, licenseType: $licenseType, town: $town, licenseExpiration: $licenseExpiration, insuranceExpiration: $insuranceExpiration ,isActive: $isActive, contractorId = $contractorId)';
}