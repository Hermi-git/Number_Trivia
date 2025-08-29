import 'package:clean_architecture_tdd/core/usecases/usecase.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';


// This annotation tells mockito to generate a mock class.
@GenerateMocks([NumberTriviaRepository])
import 'get_random_number_trivia_test.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);

  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('should get trivia from the repository', () async {
    // Arrange: set up the repository mock to return test data
    when(
      mockNumberTriviaRepository.getRandomNumberTrivia(),
    ).thenAnswer((_) async => Right(tNumberTrivia));

    // Act: call the use case with the test number
    final result = await usecase(NoParams());

    // Assert: verify correct result and interaction
    expect(result, Right(tNumberTrivia));
    verify(
      mockNumberTriviaRepository.getRandomNumberTrivia(),
    ).called(1);
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
