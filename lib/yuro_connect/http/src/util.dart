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
