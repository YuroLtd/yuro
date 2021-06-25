// import 'package:meta/meta.dart';

class HttpMethod {
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PATCH = "PATCH";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";
  static const String HEAD = "HEAD";
  static const String OPTIONS = "OPTIONS";
}

// @immutable
// class Method {
//   final String method;
//   final String path;
//
//   const Method({required this.method, required this.path});
// }
//
// @immutable
// class GET extends Method {
//   const GET(String path) : super(method: HttpMethod.GET, path: path);
// }
//
// @immutable
// class POST extends Method {
//   const POST(String path) : super(method: HttpMethod.POST, path: path);
// }
//
// @immutable
// class PATCH extends Method {
//   const PATCH(String path) : super(method: HttpMethod.PATCH, path: path);
// }
//
// @immutable
// class PUT extends Method {
//   const PUT(String path) : super(method: HttpMethod.PUT, path: path);
// }
//
// @immutable
// class DELETE extends Method {
//   const DELETE(String path) : super(method: HttpMethod.DELETE, path: path);
// }
//
// @immutable
// class HEAD extends Method {
//   const HEAD(String path) : super(method: HttpMethod.HEAD, path: path);
// }
//
// @immutable
// class OPTIONS extends Method {
//   const OPTIONS(String path) : super(method: HttpMethod.OPTIONS, path: path);
// }


// @immutable
// class Headers {
//   final Map<String, dynamic>? headers;
//
//   const Headers([this.headers]);
// }

// @immutable
// class Extras {
//   final Map<String, dynamic>? extras;
//
//   const Extras([this.extras]);
// }
//
// @immutable
// class Path {
//   final String? name;
//
//   const Path([this.name]);
// }
//
// @immutable
// class Query {
//   final String? name;
//
//   const Query([this.name]);
// }
//
// @immutable
// class QueryMap {
//   const QueryMap();
// }
//
// @immutable
// class Field {
//   final String? name;
//
//   const Field([this.name]);
// }
//
// @immutable
// class FieldMap {
//   const FieldMap();
// }
//
// @immutable
// class Object {
//   const Object();
// }
//
// enum FileUploadType { FILE, ARRAY }
//
// @immutable
// class Multipart {
//   final FileUploadType fileUploadType;
//
//   const Multipart({this.fileUploadType = FileUploadType.ARRAY});
// }
//
// @immutable
// class FieldPart {
//   final String? name;
//
//   const FieldPart({this.name});
// }
//
// @immutable
// class FilePart {
//   final String? name;
//
//   const FilePart({this.name});
// }
//
// @immutable
// class MultipartMap {
//   const MultipartMap();
// }
