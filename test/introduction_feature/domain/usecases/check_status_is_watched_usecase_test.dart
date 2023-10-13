import 'package:dawini_full/introduction_feature/domain/entity/introduction_entity.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/check_status_is_watched_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  CheckWatchingStatusUseCase? checkWatchingStatusUseCase;
  MockIntroductionRepository? mockIntroductionRepository;
  const testIntroductionData = IntroductionEntity(
      language: 'English', whoAreYou: 'Patient', isShowed: false);

  setUp(() {
    mockIntroductionRepository = MockIntroductionRepository();
    checkWatchingStatusUseCase =
        CheckWatchingStatusUseCase(repository: mockIntroductionRepository!);
  });

  test(
      'should return the state of the introduction screen if it has been watched or not',
      () async {
// arrange
    when(mockIntroductionRepository!.getIntroductionInfo())
        .thenAnswer((_) async => testIntroductionData.isShowed);
//act
    final result = await checkWatchingStatusUseCase!.execute();

// assert
    expect(result, testIntroductionData.isShowed);
  });
}
