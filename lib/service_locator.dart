import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:signify_quotes_app/core/network/network_info.dart';

import 'package:signify_quotes_app/features/quotes/cubit/quotes_cubit.dart';
import 'package:signify_quotes_app/features/quotes/data/datasources/quote_remote_data_source.dart';
import 'package:signify_quotes_app/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:signify_quotes_app/features/quotes/domain/repositories/quote_repository.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/fetch_quotes.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/rate_quote.dart';
import 'package:signify_quotes_app/features/quotes/domain/usecases/toggle_favorite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(Connectivity.new)

    // Core
    ..registerLazySingleton(() => NetworkInfo(sl()))

    // Data sources
    ..registerLazySingleton<RemoteQuoteDataSource>(
        () => RemoteQuoteDataSourceImpl(client: sl()))

    // Repositories
    ..registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl(),
        ))

  // Use cases
  ..registerLazySingleton(() => FetchQuotes(sl()))
  ..registerLazySingleton(() => RateQuote(sl()))
  ..registerLazySingleton(() => ToggleFavorite(sl()))

  // Cubit
  ..registerFactory(() => QuotesCubit(
        fetchQuotes: sl(),
        rateQuote: sl(),
        toggleFavorite: sl(),
      ));
}
