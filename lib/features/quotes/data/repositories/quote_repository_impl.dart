import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_data_source.dart';
import '../models/quote_model.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final RemoteQuoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  late Database database;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  }) {
    initDb();
  }

  Future<void> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quotes(id TEXT PRIMARY KEY, author TEXT, content TEXT, isFavorite INTEGER, rating INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // If you have any migrations, handle them here
        if (oldVersion < 1) {
          await db.execute(
            'ALTER TABLE quotes ADD COLUMN isFavorite INTEGER DEFAULT 0',
          );
        }
      },
    );
  }

  @override
  Future<List<Quote>> fetchQuotes() async {
    if (await networkInfo.isConnected) {
      final remoteQuotes = await remoteDataSource.fetchQuotes();
      final batch = database.batch();
      for (var quote in remoteQuotes) {
        batch.insert(
          'quotes',
          quote.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
      return remoteQuotes;
    } else {
      final localQuotes = await database.query('quotes');
      return localQuotes.map((json) => QuoteModel.fromJson(json)).toList();
    }
  }

  @override
  Future<void> rateQuote(String id, int rating) async {
    await database.update(
      'quotes',
      {'rating': rating},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await database.update(
      'quotes',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  @override
  Future<void> changeValue(String id, String value) async {
    await database.update(
      'quotes',
      {'content': value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
