import 'package:dio/dio.dart';
import 'package:yuro/yuro_core/yuro_core.dart';

abstract class HttpBase extends YuroLifeCycle {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  // final List<Observer> observers = [];
  //
  // T transform<T>(dynamic json);
  //
  // Observer<T> get<T>(String path, [Map<String, dynamic>? queryParameters]) {
  //   var observer = Observer<T>.fromFetch(_fetch(HttpMethod.GET, path, queryParameters: queryParameters));
  //   observers.add(observer);
  //   return observer;
  // }
  //
  // Observer<T> post<T>({required String path, dynamic data}) {
  //   var observer = Observer<T>.fromFetch(_fetch(HttpMethod.POST, path, data: data));
  //   observers.add(observer);
  //   return observer;
  // }
  //
  // Future<T> _fetch<T>(
  //     String method,
  //     String path, {
  //       Map<String, dynamic>? queryParameters,
  //       dynamic data,
  //       Map<String, dynamic>? extra,
  //       Map<String, dynamic>? headers,
  //       ProgressCallback? onSendProgress,
  //       ProgressCallback? onReceiveProgress,
  //     }) async {
  //   var requestOptions = Options(method: method, headers: headers, extra: extra).compose(
  //     _dio.options,
  //     path,
  //     queryParameters: queryParameters,
  //     data: data,
  //     onSendProgress: onSendProgress,
  //     onReceiveProgress: onReceiveProgress,
  //   );
  //   var response = await _dio.fetch(requestOptions);
  //   var httpResult = HttpResult.fromJson(response.data!);
  //   return transform<T>(httpResult.data);
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   var iterator = observers.iterator;
  //   while (iterator.moveNext()) {
  //     observers.remove(iterator.current..cancel());
  //   }
  // }
}

