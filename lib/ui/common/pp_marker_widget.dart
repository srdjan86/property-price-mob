import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMarkerWidget extends StatefulWidget {
  final Function onTap;
  final String id;

  PPMarkerWidget({Key key, this.onTap, this.id}) : super(key: key);

  @override
  _PPMarkerWidgetState createState() => _PPMarkerWidgetState();
}

class _PPMarkerWidgetState extends State<PPMarkerWidget> {
  final sinePeriod = pi;
  double _endValue = 0;
  @override
  Widget build(BuildContext context) {
    PPMapViewModel mapViewmodel = Provider.of(context);

    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() {
          if (_endValue == sinePeriod) {
            _endValue = 0;
          } else {
            _endValue = sinePeriod;
          }
        });
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: _endValue),
        duration: Duration(milliseconds: 200),
        child: Image.asset(
          'assets/images/residence-512.png',
          height: 10,
          width: 10,
          color: mapViewmodel.selectedMarkerId == widget.id
              ? Colors.blue
              : Colors.black,
        ),
        builder: (_, double value, Widget child) {
          double offset = sin(value - pi);
          return Transform.translate(
            offset: Offset(0, offset * 2),
            child: child,
          );
        },
      ),
    );
  }
}
