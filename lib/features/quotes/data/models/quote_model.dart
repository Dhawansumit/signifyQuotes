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
    return QuoteModel(
      id: (json['_id'] ?? '0').toString(),
      author: json['author'].toString(),
      content: json['content'].toString(),
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
