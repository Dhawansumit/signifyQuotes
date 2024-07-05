
part of 'quotes_cubit.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object?> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;

  const QuotesLoaded({required this.quotes});

  @override
  List<Object?> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError({required this.message});

  @override
  List<Object?> get props => [message];
}