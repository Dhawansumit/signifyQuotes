import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:signify_quotes_app/features/quotes/data/models/quote_model.dart';

abstract class RemoteQuoteDataSource {
  Future<List<QuoteModel>> fetchQuotes();
}

class RemoteQuoteDataSourceImpl implements RemoteQuoteDataSource {

  RemoteQuoteDataSourceImpl({required this.client});
  final http.Client client;

  @override
  Future<List<QuoteModel>> fetchQuotes() async {
    final response =
        await client.get(Uri.parse('https://api.quotable.io/quotes?limit=50'));

    if (response.statusCode == 200) {
      final jsonList =
          json.decode(response.body)['results'] as List<dynamic>;
      return jsonList
          .map((json) => QuoteModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
