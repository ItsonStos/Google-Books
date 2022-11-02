import 'package:flutter_google_book/features/book/datasources/book_remote_datasource.dart';
import 'package:flutter_google_book/features/book/models/book_model.dart';

abstract class IBookRepository {
  Future<List<BookModel>> fetchBooks(String keyWordVolume);
}

class BookRepository implements IBookRepository {
  final IBookRemoteDataSource _bookDataSource;
  const BookRepository(this._bookDataSource);

  @override
  Future<List<BookModel>> fetchBooks(String keyWordVolume) async {
    try {
      final String keyWordVolumeNormalize = keyWordVolume.replaceAll(' ', '+');
      return await _bookDataSource.fetchBooks(keyWordVolumeNormalize);
    } catch (_) {
      rethrow;
    }
  }
}