import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:test/test.dart';

void main() {
  test('LicenseDto works successfully', () {
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
}
