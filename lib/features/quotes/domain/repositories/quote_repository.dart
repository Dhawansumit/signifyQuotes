import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<List<Quote>> fetchQuotes();
  Future<void> rateQuote(String id, int rating);
  Future<void> toggleFavorite(String id, bool isFavorite);
  Future<void> changeValue(String id, String value);
}
