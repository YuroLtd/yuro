
import 'package:example/export.dart';

class ResponseInterceptor extends Interceptor {
  final Dio dio;

  ResponseInterceptor(this.dio);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 拦截无效返回
    if (response.data == null) {
      handler.reject(
          DioError(
              requestOptions: response.requestOptions,
              response: response,
              type: DioErrorType.other,
              error: 'RESPONSE_EMPTY'),
          true);
    }
    // 拦截错误状态
    else if (response.data['code'] != 200) {
      // 拦截401状态,如果refreshToken没有过期,则刷新token并重新发起请求
      // final refreshExpireTime = Yuro.sp.getInt(KEY_REFRESH_EXPIRE_TIME) ?? 0;
      // if (response.data['code'] == CODE_ACCESS_TOKEN_EXPIRE && Yuro.currentTimeStamp < refreshExpireTime) {
      //   _refreshTokenAndRetry(response, handler);
      // }
      // // 拦截1000状态,refreshToken过期,发送登出弹窗
      // else if (response.data['code'] == CODE_REFRESH_TOKEN_EXPIRE) {
      //   StreamEvent(CODE_LOGIN_EXPIRE, msg: '登录已过期, 请重新登录').post();
      //   handler.reject(DioError(
      //       requestOptions: response.requestOptions,
      //       response: response,
      //       type: DioErrorType.other,
      //       error: response.data['msg']));
      // }
      // 其它状态,直接返回
      // else {
        handler.reject(
            DioError(
                requestOptions: response.requestOptions,
                response: response,
                type: DioErrorType.other,
                error: response.data['msg']),
            true);
      // }
    }
    // 正常返回
    else {
      handler.next(response..data = response.data['data']);
    }
  }

  // // 刷新token并重新请求
  // // 如果token刷新失败,则进入错误处理拦截器,并清空正在排队的请求
  // void _refreshTokenAndRetry(Response response, ResponseInterceptorHandler handler) {
  //   dio.lock();
  //   final _dio = Dio()
  //     ..baseUrl = dio.options.baseUrl
  //     ..interceptors.addAll(dio.interceptors)
  //     ..httpClientAdapter = dio.httpClientAdapter;
  //   final refreshToken = Yuro.sp.getString(KEY_REFRESH_TOKEN);
  //   _dio.post('/auth/refresh', data: {'refreshToken': refreshToken, 'device': 'APP'}).then((result) {
  //     // 保存新的token
  //     final newAccessToken = result.data['access_token'] as String;
  //     Yuro.sp.setString(KEY_ACCESS_TOKEN, newAccessToken);
  //     // 替换旧的请求中的Authorization,再重新发起请求
  //     final options = response.requestOptions.copyWith();
  //     options.headers['Authorization'] = 'Bearer $newAccessToken';
  //     _dio.fetch(options).then((value) => handler.resolve(value));
  //   }).catchError((err, stackTrace) {
  //     // 刷新令牌失败后,清空等待队列,并返回错误
  //     dio.clear();
  //     handler.reject(
  //         DioError(
  //           requestOptions: response.requestOptions,
  //           response: err is DioError ? err.response : response,
  //           type: DioErrorType.other,
  //           error: err is DioError ? err.error : err,
  //         ),
  //         true);
  //   }).whenComplete(() => dio.unlock());
  // }
}
