import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:test/test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group(AuthenticationBloc, () {
    late AuthenticationBloc authBloc;
    late MockAuthenticationRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      authBloc = AuthenticationBloc(authenticationRepository: mockRepository);
    });

    test('initial state is ', () {
      expect(authBloc.state, equals(const AuthenticationState.unknown()));
    });
  });
}
