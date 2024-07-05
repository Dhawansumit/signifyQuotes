// test/domain/usecases/rate_quote_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signify_quotes_app/features/quotes/quotes.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late RateQuote usecase;
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = RateQuote(mockQuoteRepository);
  });

  final tId = '1';
  final tRating = 5;

  test('should rate the quote in the repository', () async {
    // arrange
    when(() => mockQuoteRepository.rateQuote(tId, tRating)).thenAnswer((_) async => Future.value());

    // act
    await usecase(RateQuoteParams(id: tId, rating: tRating));

    // assert
    verify(() => mockQuoteRepository.rateQuote(tId, tRating));
    verifyNoMoreInteractions(mockQuoteRepository);
  });
}
