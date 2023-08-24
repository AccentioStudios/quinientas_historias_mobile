import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quinientas_historias/core/data/dto/auth_dto.dart';
import 'package:quinientas_historias/core/utils/functions.dart';
import 'package:quinientas_historias/features/auth/data/models/login_model.dart';
import 'package:quinientas_historias/features/auth/data/repositories/auth_repository.dart';
import 'package:quinientas_historias/features/auth/data/useCases/auth_usecases.dart';
import 'package:quinientas_historias/features/auth/ui/bloc/cubit/auth_cubit.dart';

class MockAuthCubit extends MockBloc<AuthCubit, AuthState>
    implements AuthCubit {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthDto extends Mock implements AuthDto {}

void main() {
  late final MockAuthRepository repository;
  late final AuthCubit cubit;
  setUpAll(() {
    registerFallbackValue(AuthRequest(accessToken: getRandomString(10)));
    repository = MockAuthRepository();
    cubit = AuthCubit(authUseCases: AuthUseCases(repository: repository));

    MockAuthDto mockAuthDto = MockAuthDto();
    when(() => repository.login(any()))
        .thenAnswer((_) => Stream.value(mockAuthDto));
  });

  group('AuthCubit', () {
    blocTest(
      'should return login without errors',
      build: () {
        return cubit;
      },
      act: (AuthCubit b) {
        b.loginIntoTelle(
          accessToken: getRandomString(10),
          firebaseToken: getRandomString(10),
          onError: () {},
          onSuccess: () {},
        );
      },
      verify: (bloc) {
        expect(cubit.state.httpFailure, isNull);
      },
    );

    test('should validate email', () {
      expect(cubit.validateEmail(''), false);
      expect(cubit.validateEmail('test'), false);
      expect(cubit.validateEmail('test@test'), false);
      expect(cubit.validateEmail('alvaro@accentiostudios.com'), true);
    });
  });
}
