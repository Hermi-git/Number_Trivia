import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

// This annotation tells mockito to generate a mock class.
@GenerateMocks([NumberTriviaRepository])
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');

  test('should get trivia for the number from the repository', () async {
    // Arrange: set up the repository mock to return test data
    when(
      mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber),
    ).thenAnswer((_) async => Right(tNumberTrivia));

    // Act: call the use case with the test number
    final result = await usecase(Params(number: tNumber));

    // Assert: verify correct result and interaction
    expect(result, Right(tNumberTrivia));
    verify(
      mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber),
    ).called(1);
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
