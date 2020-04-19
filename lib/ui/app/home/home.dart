import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Sidebar(),
      ),
      body: Center(
        child: Text('center'),
      ),
    );
  }
}
