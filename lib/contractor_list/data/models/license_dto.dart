/*Wht this file is for:
creating a model for our License data object which should store data returned by the Contractor db
*/

class LicenseDto { //properties of the license class
  final String licenseNumber;
  final String licenseType;
  final String town;
  final String id;
  final String licenseExpiration;
  final String? insuranceExpiration;
  final String isActive; //with the ? it allows nulls values for the attributes
  final String contractorId;
  
  const LicenseDto({ //constructor this allow us to create an instance of License by passing licenseNumber License type etc
    required this.licenseNumber,
    required this.licenseType,
    required this.town,
    required this.id,
    required this.licenseExpiration,
    this.insuranceExpiration,
    required this.isActive,
    required this.contractorId
  });
//this allows us to create a licenseDto instance form a JSON object
  //this is called serializing JSON inside model classes (serializing is turning a data structure into a string or the process of translating ds to and from a more easily readable format(encoding = serializing))
  //this is a constrcutor for constructing new Licenses instance from a map structure
  //the toJson() method, convers the LicenseDto instance into a map
  //setting up instrcutinos for how to turn JSON data into a USER object^
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