import 'package:flutter/material.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_popup_item.dart';

class PPMapPopup extends StatelessWidget {
  final List<Contract> contracts;
  const PPMapPopup({Key key, this.contracts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 150,
        // width: MediaQuery.of(context).size.width - 40,
        color: Colors.green,
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
        ),
      ),
    );
  }
}
