import 'dart:math';

import 'package:flutter/material.dart';
import 'package:utopic_toast/utopic_toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utopic Toast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return ToastOverlay(
          child: child,
        );
      },
      home: MyHomePage(title: 'Utopic Toast Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showRandomToast() {
    var rand = Random();
    final randomStringLength = rand.nextInt(200);
    List<int> charCodes = List<int>.generate(randomStringLength, (_) {
      return rand.nextInt(33) + 89;
    });
    ToastManager().showToast(
      String.fromCharCodes(charCodes),
      type: ToastType.values[rand.nextInt(ToastType.values.length)],
      action: rand.nextBool()
          ? SnackBarAction(
              label: 'HAY',
              onPressed: () {
                print('yay');
              },
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push the FAB to show random toast',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showRandomToast,
        tooltip: 'Show Random Toast',
        child: Icon(Icons.message),
      ),
    );
  }
}
