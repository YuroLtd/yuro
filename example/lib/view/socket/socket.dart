import 'package:example/export.dart';
import 'package:flutter/material.dart';

class SocketDemo extends StatefulWidget {
  const SocketDemo({super.key});

  @override
  State<SocketDemo> createState() => _SocketDemoState();
}

class _SocketDemoState extends State<SocketDemo> {
  final MySocketServer server = MySocketServer();

  void start() {
    server.start('192.168.0.5');
  }

  void close() {
    server.close();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Socket Server')),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(onPressed: start, child: const Text('启动')),
              ElevatedButton(onPressed: close, child: const Text('关闭')),
            ])
          ],
        ),
      );
}

class MySocketServer extends SocketServer {}
