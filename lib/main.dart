import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

void main() => runApp(WinApp());

class WinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantastyczne nazwy',
      home: MyHomePage(title: "Fantastyczne nazwy"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    DesktopWindow.setWindowSize(Size(800, 600));
    DesktopWindow.setMinWindowSize(Size(400, 400));

    // DesktopWindow.setMaxWindowSize(Size(1366, 768));

    return Scaffold(body: Container(child: Text('napis na środku')));
  }
}
