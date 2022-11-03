import 'package:dio/dio.dart';
import 'package:flutter_google_book/core/library/environment_helper.dart';
import 'package:flutter_google_book/core/model/response_htttp_model.dart';
import 'package:flutter_google_book/core/service/http_client.dart';

class HttpClientDio implements IHttpClient {
  final IEnvironmentHelper _environmentHelper;
  const HttpClientDio(this._environmentHelper);

  @override
  Future<ResponseHttpModel> get(String url) async {
    final Dio dio = _createInstanceDio(_environmentHelper.keyAuthorization);
    try {
      final response = await dio.get(url);
      return ResponseHttpModel(data: response.data, statusCode: response.statusCode);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<ResponseHttpModel> post(String url, {String? data}) async {
    final Dio dio = _createInstanceDio(_environmentHelper.keyAuthorization);
    try {
      final response = await dio.post(url, data: data);
      return ResponseHttpModel(data: response.data, statusCode: response.statusCode);
    } catch (_) {
      rethrow;
    }
  }

  @override
  IEnvironmentHelper get environmentHelper => _environmentHelper;

  Dio _createInstanceDio(String authorization) {
    return Dio(
      BaseOptions(
        headers: {
          'key': authorization,
        },
      ),
    );
  }
}