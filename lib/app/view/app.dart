import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signify_quotes_app/features/quotes/quotes.dart';
import 'package:signify_quotes_app/l10n/l10n.dart';
import 'package:signify_quotes_app/service_locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<QuotesCubit>()..getQuotes(),
        ),
      ],
      child: MaterialApp(
        title: 'Random Quotes',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: QuotesPage(),
      ),
    );
  }
}
