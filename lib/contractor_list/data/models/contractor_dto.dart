class ContractorDto {
  final String id;
  final String companyname;
  final String address;
  final String phone;
  final String? owner;
  final String? email;

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
      id: json['id'] ?? '',
      companyname: json['company_name'],
      address: json['address'],
      phone: json['phone'],
      owner: json['owner'],
      email: json['email'],
    );
  }
  @override
  String toString() =>
      'ContractorDto(id: $id, companyname: $companyname, owner: $owner, email: $email, address: $address, phone: $phone,)';
}
