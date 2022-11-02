class ResponseHttpModel {
  final dynamic data;
  final int? statusCode;

  const ResponseHttpModel({
    required this.data,
    required this.statusCode,
  });
}