import 'dart:convert';
import 'dart:io';

class IOSinkProxy implements IOSink {
  IOSinkProxy(this._ioSink, this._onErr) : encoding = _ioSink.encoding;

  final IOSink _ioSink;
  final Function(dynamic e) _onErr;

  bool isClosed = false;

  @override
  Encoding encoding;

  @override
  void add(List<int> data) {
    try {
      _ioSink.add(data);
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) => _ioSink.addError(error, stackTrace);

  @override
  Future addStream(Stream<List<int>> stream) async {
    try {
      return _ioSink.addStream(stream);
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  Future close() async {
    try {
      final res = await _ioSink.close();
      isClosed = true;
      return res;
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  Future get done => _ioSink.done;

  @override
  Future flush() async {
    try {
      return await _ioSink.flush();
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  void write(Object? object) {
    try {
      return _ioSink.write(object);
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    try {
      return _ioSink.writeAll(objects, separator);
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  void writeCharCode(int charCode) {
    try {
      return _ioSink.writeCharCode(charCode);
    } catch (e) {
      _onErr.call(e);
    }
  }

  @override
  void writeln([Object? object = ""]) {
    try {
      return _ioSink.writeln(object);
    } catch (e) {
      _onErr.call(e);
    }
  }
}
