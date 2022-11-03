import 'package:flutter_google_book/core/library/environment_helper.dart';
import 'package:flutter_google_book/core/model/response_htttp_model.dart';

abstract class IHttpClient {
  Future<ResponseHttpModel> get(String url);
  Future<ResponseHttpModel> post(String url, {String? data});
  IEnvironmentHelper get environmentHelper;
}