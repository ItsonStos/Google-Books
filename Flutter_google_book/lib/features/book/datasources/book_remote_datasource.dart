
import 'package:flutter_google_book/features/book/models/book_model.dart';
import 'package:flutter_google_book/core/model/response_htttp_model.dart';
import 'package:flutter_google_book/core/service/http_client.dart';

abstract class IBookRemoteDataSource {
  Future<List<BookModel>> fetchBooks(String keyWordVolume);
}

class BookRemoteDataSource implements IBookRemoteDataSource {
  final IHttpClient _httpClient;
  const BookRemoteDataSource(this._httpClient);

  @override
  Future<List<BookModel>> fetchBooks(String keyWordVolume) async {
    try {
      final ResponseHttpModel responseHttpModel = await _httpClient.get('${_httpClient.environmentHelper.urlBookVolumes}?q=$keyWordVolume');
      if (responseHttpModel.data is Map && responseHttpModel.data['items'] is List) {
        return responseHttpModel.data['items'].map<BookModel>((map) => BookModel.fromMap(map)).toList();
      }
    } catch (_) {
      rethrow;
    }
    return [];
  }
}