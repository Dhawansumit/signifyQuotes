import 'package:equatable/equatable.dart';

import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class RateQuote extends UseCase<void, RateQuoteParams> {
  final QuoteRepository repository;

  RateQuote(this.repository);

  @override
  Future<void> call(RateQuoteParams params) async {
    return await repository.rateQuote(params.id, params.rating);
  }
}

class RateQuoteParams extends Equatable {
  final String id;
  final int rating;

  RateQuoteParams({required this.id, required this.rating});

  @override
  List<Object?> get props => [id, rating];
}
