import 'package:flutter/material.dart';
import 'package:property_price_mob/model/contract.dart';

class PPMapPopupItem extends StatelessWidget {
  final Contract contract;
  const PPMapPopupItem({Key key, this.contract}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      width: MediaQuery.of(context).size.width - 50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('price ${contract.price} ${contract.priceCurrency}'),
              Text('date ${contract.date}'),
              Text(contract.object),
              Flexible(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contract.properties.length,
                  itemBuilder: (context, ind) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('$ind. '),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Property type: ${contract.properties[ind].type}',
                            ),
                            Text(
                                'Property size: ${contract.properties[ind].size}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
