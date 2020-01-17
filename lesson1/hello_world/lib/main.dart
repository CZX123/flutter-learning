import 'package:flutter/material.dart';

/// Every Dart program first runs the main function
/// Every Flutter app needs to run the `runApp` function,
/// which accepts any [Widget] as its argument.
void main() => runApp(MyApp());

/// Create custom widgets by extending [StatelessWidget] or [StatefulWidget]
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// The first widget that gets build is usually a [MaterialApp]
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Does nothing for now
        tooltip: 'Add Something',
        child: Icon(Icons.add),
      ),
    );
  }
}
