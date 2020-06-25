import 'package:flutter/material.dart';
import 'package:property_price_mob/dependency_list.dart';
import 'package:property_price_mob/ui/app/home/home.dart';
import 'package:provider/provider.dart';

import '../../dependency_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...independentProviders,
        ...dependentProviders,
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
