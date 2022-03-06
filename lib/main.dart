import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Fantastyczne nazwy');
    setWindowMinSize(const Size(400, 300));
    setWindowMaxSize(Size.infinite);
  }
  runApp(WinApp());
}

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
  final myController = TextEditingController();

  String txt =
      "Wpisz powyżej sylaby oddzielając je przecinkiem i kliknij przycisk generuj";

  int syllabes_amount = 3;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  String fantasticNames(String syllabes) {
    //['gh' , 'aa' , 'ver' , 'tou' , 'ki']
    // gh, aa, ver, tou, ki

    // List<String> sylaby = ['gh', 'aa', 'ver', 'tou', 'ki'];
    syllabes = syllabes.replaceAll(" ", '');
    List<String> syllabes_list = syllabes.split(",");

    if (syllabes_list.length < syllabes_amount) {
      return "Liczba sylab musi wynosić conajmniej ${syllabes_amount}";
    }

    var rnd = Random();
    String wynik = "";

    for (int i = 0; i < syllabes_amount; i++) {
      int losowa_liczba = rnd.nextInt(syllabes_list.length);
      String sylaba = syllabes_list[losowa_liczba];
      syllabes_list.removeAt(losowa_liczba);
      wynik = wynik + sylaba;
    }

    return wynik;
  }

  var syllabes_amount_items = [2, 3, 4, 5];
  var currentItem = "3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fantastyczne nazwy'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: myController,
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      txt = fantasticNames(myController.text);
                    });
                  },
                  child: Text(
                    "generuj",
                    style: TextStyle(fontSize: 25),
                  )),
              Row(
                children: [
                  Text('Liczba sylab: ', style: TextStyle(fontSize: 30)),
                  Center(
                      child: DropdownButton(
                          items: <int>[2, 3, 4, 5].map((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          value: currentItem,
                          onChanged: (value) {
                            currentItem = value.toString();
                            setState(() {
                              syllabes_amount = int.parse(value.toString());
                            });
                          }))
                ],
              ),
              Text(txt, style: TextStyle(fontSize: 30))
            ],
          )),
    );
  }
}
