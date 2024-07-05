import 'package:flutter/material.dart';

import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';

class QuoteCard extends StatefulWidget {
  QuoteCard({
    required this.textEditingController,
    required this.quote,
    required this.onRate,
    required this.onFavoriteToggle,
    required this.onChangeValue,
    super.key,
  });
  final Quote quote;
  final TextEditingController textEditingController;
  final Function(int) onRate;
  final Function(bool) onFavoriteToggle;
  final Function(String) onChangeValue;

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: widget.textEditingController,
            maxLines: null,
            minLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() {});
            },
          ),
          if (widget.textEditingController.value.text != widget.quote.content)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Text color
              ),
              onPressed: () {
                widget.onChangeValue(widget.textEditingController.value.text);
              },
              child: const Text('Save'),
            ),
          const SizedBox(height: 20),
          Text(
            '- ${widget.quote.author}',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < widget.quote.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => widget.onRate(index + 1),
              );
            }),
          ),
          IconButton(
            icon: Icon(
              widget.quote.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => widget.onFavoriteToggle(!widget.quote.isFavorite),
          ),
        ],
      ),
    );
  }
}
