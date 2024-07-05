import 'package:equatable/equatable.dart';

import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class ChangeQuoteValue extends UseCase<void, ChangeQuoteValueParams> {
  final QuoteRepository repository;

  ChangeQuoteValue(this.repository);

  @override
  Future<void> call(ChangeQuoteValueParams params) async {
    return await repository.changeValue(params.id, params.value);
  }
}

class ChangeQuoteValueParams extends Equatable {
  final String id;
  final String value;

  ChangeQuoteValueParams({required this.id, required this.value});

  @override
  List<Object?> get props => [id, value];
}
