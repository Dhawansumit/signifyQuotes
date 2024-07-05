import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String author;
  final String content;
  final bool isFavorite;
  final int rating;

  Quote({
    required this.id,
    required this.author,
    required this.content,
    this.isFavorite = false,
    this.rating = 0,
  });

  @override
  List<Object?> get props => [id, author, content, isFavorite, rating];
}
