// test/domain/usecases/fetch_quotes_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/fetch_quotes.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late FetchQuotes usecase;
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = FetchQuotes(mockQuoteRepository);
  });

  final tQuotes = [
    Quote(id: '1', author: 'Author 1', content: 'Quote 1', isFavorite: false, rating: 0),
    Quote(id: '2', author: 'Author 2', content: 'Quote 2', isFavorite: false, rating: 0),
  ];

  test('should get quotes from the repository', () async {
    // arrange
    when(() => mockQuoteRepository.fetchQuotes()).thenAnswer((_) async => tQuotes);

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, tQuotes);
    verify(() => mockQuoteRepository.fetchQuotes());
    verifyNoMoreInteractions(mockQuoteRepository);
  });
}
