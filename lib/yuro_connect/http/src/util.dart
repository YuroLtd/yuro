class HttpMethod {
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PATCH = "PATCH";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";
}

class HttpResult {
  int code;
  String key;
  dynamic data;
  String time;

  HttpResult(this.code, this.key, this.data, this.time);

  factory HttpResult.fromJson(Map<String, dynamic> json) => HttpResult(json["code"], json['key'], json["data"], json['time']);
}

class HttpError {
  int code;
  String message;

  HttpError(this.code, this.message);
}
