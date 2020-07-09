import 'package:flutter/material.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/utils/price_util.dart';

class PPMapPopupItem extends StatelessWidget {
  final Contract contract;
  const PPMapPopupItem({Key key, this.contract}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        'pp map popup item build, ${contract.properties[0].location.lat} ${contract.properties[0].location.lon}}');
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width - 50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(contract.date),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_offer,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${PriceUtil.format(contract.price)} ${contract.priceCurrency}',
                        style: TextStyle(
                          // height: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(contract.object),
              SizedBox(height: 10),
              ListView.builder(
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: contract.properties.length,
                itemBuilder: (context, ind) => Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${ind + 1}. '),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Property type: ${contract.properties[ind].type}',
                            ),
                            Row(
                              children: <Widget>[
                                Text(contract.properties[ind].size.toString()),
                                Image.asset(
                                  'assets/images/square_meter.png',
                                  height: 20,
                                  width: 20,
                                ),
                                //http://maps.google.com/maps?t=k&q=loc:44.8045+20.3819
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
