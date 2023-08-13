import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Default Directory')),
        body: Center(
          child: DefaultDirectoryWidget(),
        ),
      ),
    );
  }
}

class DefaultDirectoryWidget extends StatefulWidget {
  @override
  _DefaultDirectoryWidgetState createState() => _DefaultDirectoryWidgetState();
}

class _DefaultDirectoryWidgetState extends State<DefaultDirectoryWidget> {
  Future<String>? _defaultDirectory;

  @override
  void initState() {
    super.initState();
    _defaultDirectory = _getDefaultDirectory();
  }

  Future<String> _getDefaultDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _defaultDirectory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Text('Default Directory: ${snapshot.data}');
        } else {
          return Text('Unknown error occurred.');
        }
      },
    );
  }
}
