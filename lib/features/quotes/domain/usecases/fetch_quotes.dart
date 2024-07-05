import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class FetchQuotes extends UseCase<List<Quote>, NoParams> {

  FetchQuotes(this.repository);
  final QuoteRepository repository;

  @override
  Future<List<Quote>> call(NoParams params) async {
    return await repository.fetchQuotes();
  }
}
