class LicenseDto {
  const LicenseDto({
    required this.licenseNumber,
    required this.licenseType,
    required this.town,
    required this.id,
    required this.licenseExpiration,
    required this.isActive,
    required this.contractorId,
    this.insuranceExpiration,
  });
  factory LicenseDto.fromJson(Map<String, dynamic> json) {
    return LicenseDto(
      licenseNumber: json['license_number'] as String,
      licenseType: json['license_type'] as String,
      town: json['town'] as String,
      id: json['id'] as String? ?? '',
      licenseExpiration: json['license_expiration'] as String,
      insuranceExpiration: json['insurance_expiration'] as String?,
      isActive: json['is_active'].toString(),
      contractorId: json['contractor_id'] as String,
    );
  }
  final String licenseNumber;
  final String licenseType;
  final String town;
  final String id;
  final String licenseExpiration;
  final String? insuranceExpiration;
  final String isActive; //with the ? it allows nulls values for the attributes
  final String contractorId;

  @override
  String toString() => 'ContractorDto(id: $id, licenseNumber: $licenseNumber, '
      'licenseType: $licenseType, town: $town, '
      'licenseExpiration: $licenseExpiration, '
      'insuranceExpiration: $insuranceExpiration ,isActive: $isActive, '
      'contractorId = $contractorId)';
}
