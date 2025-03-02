import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:test/test.dart';

void main() {
  group('testing licenseDto', () {
    test('LicenseDto works successfully using toString', () {
      const license = LicenseDto(
        licenseNumber: 'abc',
        licenseType: '123',
        town: 'chicago',
        id: '123',
        licenseExpiration: '123',
        isActive: '123',
        contractorId: '123',
        insuranceExpiration: '123',
      );

      expect(
          license.toString(),
          'ContractorDto(id: 123, licenseNumber: abc, '
          'licenseType: 123, town: chicago, '
          'licenseExpiration: 123, '
          'insuranceExpiration: 123 ,isActive: 123, '
          'contractorId = 123)');
    });
    test('factory License Dto', () {
      final jsonLicense = {
        'license_number': '1',
        'license_type': '2',
        'town': '3',
        'id': null,
        'license_expiration': '5',
        'insurance_expiration': '6',
        'is_active': 'true',
        'contractor_id': '7',
      };

      final license = LicenseDto.fromJson(jsonLicense);

      expect(license.licenseNumber, '1');
      expect(license.licenseType, '2');
      expect(license.town, '3');
      expect(license.id, '');
      expect(license.licenseExpiration, '5');
      expect(license.insuranceExpiration, '6');
      expect(license.isActive, 'true');
      expect(license.contractorId, '7');
    });
  });
}
