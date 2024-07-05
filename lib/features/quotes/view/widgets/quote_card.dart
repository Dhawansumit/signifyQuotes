import 'package:flutter/material.dart';

import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final Function(int) onRate;
  final Function(bool) onFavoriteToggle;

  QuoteCard({
    required this.quote,
    required this.onRate,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            quote.content,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            '- ${quote.author}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < quote.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => onRate(index + 1),
              );
            }),
          ),
          IconButton(
            icon: Icon(
              quote.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => onFavoriteToggle(!quote.isFavorite),
          ),
        ],
      ),
    );
  }
}
