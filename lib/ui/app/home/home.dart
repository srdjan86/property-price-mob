import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('home build');
    HomeViewModel viewmodel = Provider.of(context);
    return Stack(children: [
      Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: Sidebar(onTap: viewmodel.getContracts),
        ),
        body: Stack(
          children: [
            PPMap(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () => _drawerKey.currentState.openDrawer(),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      viewmodel.busy
          ? Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: CircularProgressIndicator(),
              ))
          : Container()
    ]);
  }
}
