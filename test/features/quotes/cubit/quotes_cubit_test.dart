// test/features/quotes/cubit/quotes_cubit_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/quotes.dart';


class MockFetchQuotes extends Mock implements FetchQuotes {}
class MockRateQuote extends Mock implements RateQuote {}
class MockToggleFavorite extends Mock implements ToggleFavorite {}

void main() {
  late QuotesCubit quotesCubit;
  late MockFetchQuotes mockFetchQuotes;
  late MockRateQuote mockRateQuote;
  late MockToggleFavorite mockToggleFavorite;

  setUp(() {
    mockFetchQuotes = MockFetchQuotes();
    mockRateQuote = MockRateQuote();
    mockToggleFavorite = MockToggleFavorite();
    quotesCubit = QuotesCubit(
      fetchQuotes: mockFetchQuotes,
      rateQuote: mockRateQuote,
      toggleFavorite: mockToggleFavorite,
    );

    // Register fallback values for Uri type
    registerFallbackValue(NoParams());
    registerFallbackValue(RateQuoteParams(id: '1', rating: 1));
    registerFallbackValue(ToggleFavoriteParams(id: '1', isFavorite: true));
  });

  final tQuote1 = Quote(id: '1', author: 'Author 1', content: 'Quote 1', isFavorite: false, rating: 0);
  final tQuote2 = Quote(id: '2', author: 'Author 2', content: 'Quote 2', isFavorite: false, rating: 0);
  final tQuoteList = [tQuote1, tQuote2];

  blocTest<QuotesCubit, QuotesState>(
    'emits [QuotesLoading, QuotesLoaded] when getQuotes is successful',
    build: () {
      when(() => mockFetchQuotes(any())).thenAnswer((_) async => tQuoteList);
      return quotesCubit;
    },
    act: (cubit) => cubit.getQuotes(),
    expect: () => [
      QuotesLoading(),
      QuotesLoaded(quotes: tQuoteList),
    ],
  );

  blocTest<QuotesCubit, QuotesState>(
    'emits [QuotesLoading, QuotesError] when getQuotes fails',
    build: () {
      when(() => mockFetchQuotes(any())).thenThrow(Exception('Failed to load quotes'));
      return quotesCubit;
    },
    act: (cubit) => cubit.getQuotes(),
    expect: () => [
      QuotesLoading(),
      QuotesError(message: 'Exception: Failed to load quotes'),
    ],
  );

  blocTest<QuotesCubit, QuotesState>(
    'emits updated QuotesLoaded when rateQuoteCubit is called',
    build: () {
      when(() => mockRateQuote(any())).thenAnswer((_) async => {});
      return quotesCubit;
    },
    seed: () => QuotesLoaded(quotes: tQuoteList),
    act: (cubit) => cubit.rateQuoteCubit('1', 5),
    expect: () => [
      QuotesLoaded(quotes: [
        Quote(id: '1', author: 'Author 1', content: 'Quote 1', isFavorite: false, rating: 5),
        tQuote2,
      ]),
    ],
  );

  blocTest<QuotesCubit, QuotesState>(
    'emits updated QuotesLoaded when toggleFavoriteCubit is called',
    build: () {
      when(() => mockToggleFavorite(any())).thenAnswer((_) async => {});
      return quotesCubit;
    },
    seed: () => QuotesLoaded(quotes: tQuoteList),
    act: (cubit) => cubit.toggleFavoriteCubit('1', true),
    expect: () => [
      QuotesLoaded(quotes: [
        Quote(id: '1', author: 'Author 1', content: 'Quote 1', isFavorite: true, rating: 0),
        tQuote2,
      ]),
    ],
  );
}