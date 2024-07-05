import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/change_quote_value.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/fetch_quotes.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/rate_quote.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/toggle_favorite.dart';

part 'quotes_state.dart';


class QuotesCubit extends Cubit<QuotesState> {
  final FetchQuotes fetchQuotes;
  final RateQuote rateQuote;
  final ToggleFavorite toggleFavorite;
  final ChangeQuoteValue onChangValue;

  QuotesCubit({
    required this.fetchQuotes,
    required this.rateQuote,
    required this.toggleFavorite,
    required this.onChangValue,
  }) : super(QuotesInitial());

  Future<void> getQuotes() async {
    emit(QuotesLoading());
    try {
      final quotes = await fetchQuotes(NoParams());
      emit(QuotesLoaded(quotes: quotes));
    } catch (e) {
      emit(QuotesError(message: e.toString()));
    }
  }

  Future<void> rateQuoteCubit(String id, int rating) async {
    try {
      await rateQuote(RateQuoteParams(id: id, rating: rating));
      if (state is QuotesLoaded) {
        final quotes = (state as QuotesLoaded).quotes;
        final updatedQuotes = quotes.map((quote) {
          if (quote.id == id) {
            return Quote(
              id: quote.id,
              author: quote.author,
              content: quote.content,
              isFavorite: quote.isFavorite,
              rating: rating,
            );
          }
          return quote;
        }).toList();
        emit(QuotesLoaded(quotes: updatedQuotes));
      }
    } catch (e) {
      emit(QuotesError(message: e.toString()));
    }
  }

  Future<void> toggleFavoriteCubit(String id, bool isFavorite) async {
    try {
      await toggleFavorite(ToggleFavoriteParams(id: id, isFavorite: isFavorite));
      if (state is QuotesLoaded) {
        final quotes = (state as QuotesLoaded).quotes;
        final updatedQuotes = quotes.map((quote) {
          if (quote.id == id) {
            return Quote(
              id: quote.id,
              author: quote.author,
              content: quote.content,
              isFavorite: isFavorite,
              rating: quote.rating,
            );
          }
          return quote;
        }).toList();
        emit(QuotesLoaded(quotes: updatedQuotes));
      }
    } catch (e) {
      emit(QuotesError(message: e.toString()));
    }
  }

  Future<void> onChangedValueCubit(String id, String val) async {
    try {
       await onChangValue(ChangeQuoteValueParams(id: id, value: val));
      if (state is QuotesLoaded) {
        final quotes = (state as QuotesLoaded).quotes;
        final updatedQuotes = quotes.map((quote) {
          if (quote.id == id) {
            return Quote(
              id: quote.id,
              author: quote.author,
              content: val,
              isFavorite: quote.isFavorite,
              rating: quote.rating,
            );
          }
          return quote;
        }).toList();
        emit(QuotesLoaded(quotes: updatedQuotes));
      }
    } catch (e) {
      emit(QuotesError(message: e.toString()));
    }
  }
}