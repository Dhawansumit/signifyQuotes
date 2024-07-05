// test/domain/usecases/toggle_favorite_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signify_quotes_app/features/quotes/quotes.dart';


class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late ToggleFavorite usecase;
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = ToggleFavorite(mockQuoteRepository);
  });

  final tId = '1';
  final tIsFavorite = true;

  test('should toggle favorite status of the quote in the repository', () async {
    // arrange
    when(() => mockQuoteRepository.toggleFavorite(tId, tIsFavorite))
        .thenAnswer((_) async => Future.value());

    // act
    await usecase(ToggleFavoriteParams(id: tId, isFavorite: tIsFavorite));

    // assert
    verify(() => mockQuoteRepository.toggleFavorite(tId, tIsFavorite));
    verifyNoMoreInteractions(mockQuoteRepository);
  });
}
