import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _myController = TextEditingController();
  final Random _random = Random();
  late int _myNumber = _random.nextInt(101);
  String _message = ' ';
  String _textButton = 'Guess';
  bool _enableTextField = true;

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: <Widget>[
            const Text(
              'I`m thinking of a number between 1 and 100',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'It`s your turn to guess my number!',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
                child: Text(
                  _message,
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            cardInput(context),
          ]),
        ),
      ),
    );
  }

  Card cardInput(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          const Text('Try a number', style: TextStyle(fontSize: 25)),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            controller: _myController,
            enabled: _enableTextField,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: ElevatedButton(
                onPressed: () {
                  final int? numberCheck = int.tryParse(_myController.value.text);
                  setState(() {
                    if (_textButton.compareTo('Guess') == 0) {
                      checkNumber(numberCheck!, context);
                    } else {
                      setState(() {
                        _enableTextField = true;
                        _textButton = 'Guess';
                        _myNumber = _random.nextInt(101);
                        _message = '';
                      });
                    }
                    _myController.clear();
                  });
                },
                child: Text(_textButton)),
          ),
        ]),
      ),
    );
  }

  void checkNumber(int numberCheck, BuildContext context) {
    if (numberCheck > _myNumber) {
      _message = 'You tried $numberCheck Try lower';
    } else if (numberCheck < _myNumber) {
      _message = 'You tried $numberCheck Try higher';
    } else if (numberCheck == _myNumber) {
      _message = 'You tried $numberCheck You guessed right';
      dialogBox(context, numberCheck);
    }
    _myController.clear();
  }

  void dialogBox(BuildContext context, int value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: const Text('You guessed right'), content: Text('It was $value'), actions: <Widget>[
          TextButton(
              onPressed: () {
                setState(() {
                  _myNumber = _random.nextInt(101);
                  _message = '';
                  Navigator.of(context, rootNavigator: true).pop();
                });
              },
              child: const Text('Try again ?')),
          TextButton(
              onPressed: () {
                setState(() {
                  _enableTextField = false;
                  _textButton = 'Reset';
                  Navigator.of(context, rootNavigator: true).pop();
                });
              },
              child: const Text('OK'))
        ]);
      },
    );
  }
}
