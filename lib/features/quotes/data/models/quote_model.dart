import 'dart:math';

import '../../domain/entities/quote.dart';

class QuoteModel extends Quote {
  QuoteModel({
    required String? id,
    required String author,
    required String content,
    required bool isFavorite,
    required int rating,
  }) : super(
          id: id ?? '0',
          author: author,
          content: content,
          isFavorite: isFavorite,
          rating: rating,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    print(json);
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return QuoteModel(
      id: (json['_id'] ?? getRandomString(5)).toString(),
      author: json['author'].toString(),
      content: json['quote'].toString(),
      isFavorite: false,
      rating: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'isFavorite': isFavorite,
      'rating': rating,
    };
  }
}
