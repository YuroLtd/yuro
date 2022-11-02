// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class SystemApiImpl implements SystemApi {
  SystemApiImpl(this._dio);

  final Dio _dio;

  static const String _path = '/publish';

  @override
  Future<void> crashReport(crash) async {
    final headers = <String, dynamic>{};
    final extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final data = <String, dynamic>{};
    data.addAll(crash.toJson());
    final options = Options(method: 'POST', headers: headers, extra: extra)
        .compose(_dio.options, '$_path/open/api/appLogUpload',
            queryParameters: queryParameters, data: FormData.fromMap(data))
        .copyWith(
            baseUrl: _dio.options.baseUrl, contentType: 'multipart/form-data');
    await _dio.fetch(options);
  }
}
