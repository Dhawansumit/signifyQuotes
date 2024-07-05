import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signify_quotes_app/features/quotes/cubit/quotes_cubit.dart';
import 'package:signify_quotes_app/features/quotes/domain/entities/quote.dart';
import 'package:signify_quotes_app/features/quotes/view/widgets/quote_card.dart';

class QuotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: BlocProvider(
        create: (context) => context.read<QuotesCubit>()..getQuotes(),
        child: BlocBuilder<QuotesCubit, QuotesState>(
          builder: (context, state) {
            if (state is QuotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuotesLoaded) {
              return QuotesView(quotes: state.quotes);
            } else if (state is QuotesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class QuotesView extends StatefulWidget {
  final List<Quote> quotes;

  QuotesView({required this.quotes});

  @override
  _QuotesViewState createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  int currentIndex = 0;

  void _showNextQuote() {
    if (currentIndex < widget.quotes.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No more quotes')));
    }
  }

  void _showPreviousQuote() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No previous quotes')));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: QuoteCard(
              textEditingController: TextEditingController(
                text: widget.quotes[currentIndex].content,
              ),
              quote: widget.quotes[currentIndex],
              onRate: (rating) {
                context
                    .read<QuotesCubit>()
                    .rateQuoteCubit(widget.quotes[currentIndex].id, rating);
              },
              onFavoriteToggle: (isFavorite) {
                context.read<QuotesCubit>().toggleFavoriteCubit(
                    widget.quotes[currentIndex].id, isFavorite);
              },
              onChangeValue: (val) {
                context
                    .read<QuotesCubit>()
                    .onChangedValueCubit(widget.quotes[currentIndex].id, val);
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _showPreviousQuote,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _showNextQuote,
            ),
          ],
        ),
      ],
    );
  }
}
