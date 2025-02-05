class ContractorDto {
  ContractorDto({
    required this.id,
    required this.companyname,
    required this.address,
    required this.phone,
    this.owner,
    this.email,
  });

  factory ContractorDto.fromJson(Map<String, dynamic> json) {
    return ContractorDto(
      id: json['id'] as String? ?? '',
      companyname: json['company_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      owner: json['owner'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }
  final String id;
  final String companyname;
  final String address;
  final String phone;
  final String? owner;
  final String? email;

  @override
  String toString() => ' ContractorDto(id: $id, '
      'companyname: $companyname,'
      ' owner: $owner,'
      ' email: $email,'
      ' address: $address, '
      'phone: $phone,)';
}
