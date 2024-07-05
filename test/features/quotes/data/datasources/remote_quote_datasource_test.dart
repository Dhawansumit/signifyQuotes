import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:signify_quotes_app/features/quotes/quotes.dart';

// Mock class
class MockHttpClient extends Mock implements http.Client {}

// Fake class for Uri
class UriFake extends Fake implements Uri {}

void main() {
  late RemoteQuoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteQuoteDataSourceImpl(client: mockHttpClient);
  });

  final tQuoteModel = QuoteModel(
    id: null,
    author: 'Author 1',
    content: 'Quote 1',
    isFavorite: false,
    rating: 0,
  );

  final tQuoteList = [tQuoteModel];
  final tQuoteListJson =
      json.encode({'results': tQuoteList.map((q) => q.toJson()).toList()});

  test('should perform a GET request on the URL', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response(tQuoteListJson, 200));

    // act
    await dataSource.fetchQuotes();

    // assert
    verify(
      () => mockHttpClient
          .get(Uri.parse('https://api.quotable.io/quotes?limit=50')),
    );
  });

  test('should return List<QuoteModel> when the response code is 200',
      () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response(tQuoteListJson, 200));

    // act
    final result = await dataSource.fetchQuotes();

    // assert
    expect(result, tQuoteList);
  });

  test('should throw an exception when the response code is not 200', () async {
    // arrange
    when(() => mockHttpClient.get(any()))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));

    // act
    final call = dataSource.fetchQuotes();

    // assert
    expect(() => call, throwsA(isA<Exception>()));
  });
}
