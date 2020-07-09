import 'package:flutter/material.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_popup_item.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMapPopup extends StatefulWidget {
  final List<Contract> contracts;
  const PPMapPopup({Key key, this.contracts}) : super(key: key);

  @override
  _PPMapPopupState createState() => _PPMapPopupState();
}

class _PPMapPopupState extends State<PPMapPopup> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> position;
  Animation<double> opacity;
  bool visible = false;
  List<Contract> contracts;

  final alphaTween = new Tween(begin: 0.0, end: 1.0);
  // List<Contract> contracts;

  @override
  void initState() {
    _startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('pp map popup build');
    if (contracts == null) return Container();
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
          opacity: opacity,
          child: Container(
              height: 150,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 25),
                separatorBuilder: (context, i) => SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: contracts.length,
                itemBuilder: (context, index) => PPMapPopupItem(
                  contract: contracts[index],
                ),
              )),
        ),
      ),
    );
  }

  void _startAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);

    position = new Tween<Offset>(
      begin: new Offset(0.0, 1.0),
      end: new Offset(0.0, 0.0),
    ).animate(
        new CurvedAnimation(parent: controller, curve: Curves.decelerate));

    opacity = alphaTween.animate(controller);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PPMapPopup oldWidget) {
    if (widget.contracts != null) {
      setState(() {
        contracts = widget.contracts;
      });
    }
    PPMapViewModel mapViewModel = Provider.of(context, listen: false);
    if (visible && mapViewModel.selectedMarkerId == null) {
      controller.reverse();
      setState(() {
        visible = false;
      });
    } else if (!visible && mapViewModel.selectedMarkerId != null) {
      setState(() {
        visible = true;
      });
      controller.forward();
    }

    super.didUpdateWidget(oldWidget);
  }
}
