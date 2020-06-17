import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SidebarViewModel viewmodel = Provider.of(context, listen: false);
      viewmodel.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Sidebar(),
      ),
      body: PPMap(),
    );
  }
}
