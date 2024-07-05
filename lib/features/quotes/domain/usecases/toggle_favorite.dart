import 'package:equatable/equatable.dart';

import 'package:signify_quotes_app/core/usecases/usecase.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';

class ToggleFavorite extends UseCase<void, ToggleFavoriteParams> {
  final QuoteRepository repository;

  ToggleFavorite(this.repository);

  @override
  Future<void> call(ToggleFavoriteParams params) async {
    return await repository.toggleFavorite(params.id, params.isFavorite);
  }
}

class ToggleFavoriteParams extends Equatable {
  final String id;
  final bool isFavorite;

  ToggleFavoriteParams({required this.id, required this.isFavorite});

  @override
  List<Object?> get props => [id, isFavorite];
}
