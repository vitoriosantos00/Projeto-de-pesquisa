import 'package:flutter/material.dart';
import 'telaprincipal.dart';

void main() {
  return runApp(Prototipo());
}

class Prototipo extends StatelessWidget {
  const Prototipo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaPrincipal(),
    );
  }
}

/*
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), This trailing comma makes auto-formatting nicer for build methods.

*/
