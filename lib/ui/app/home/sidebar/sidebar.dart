import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:property_price_mob/ui/common/pp_dropdown_button.dart';
import 'package:property_price_mob/utils/pp_datetime.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  final Function onTap;
  Sidebar({Key key, this.onTap}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    SidebarViewModel viewmodel = Provider.of(context);
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              PPDropdownButton(
                items: viewmodel.districts,
                onChanged: (value) {
                  viewmodel.setSelectedDistrict(value);
                },
                value: viewmodel.selectedDistrict,
                hint: 'District',
              ),
              PPDropdownButton(
                items: viewmodel.cadasterDistricts,
                onChanged: (value) {
                  viewmodel.setSelectedCadesterDistrict(value);
                },
                value: viewmodel.selectedCadesterDistrict,
                hint: 'Cadester District',
              ),
              FlatButton(
                onPressed: () async {
                  final date = await _showDatePicker(
                    initialDate: viewmodel.startDate,
                  );
                  if (date != null) {
                    viewmodel.startDate = date;
                    if (date.isAfter(viewmodel.endDate)) {
                      viewmodel.endDate = date;
                    }
                  }
                },
                child: Text(PPDateTime.toEuroString(viewmodel.startDate)),
              ),
              FlatButton(
                onPressed: () async {
                  final date = await _showDatePicker(
                    initialDate: viewmodel.endDate,
                  );
                  if (date != null) {
                    viewmodel.endDate = date;
                    if (date.isBefore(viewmodel.startDate)) {
                      viewmodel.startDate = date;
                    }
                  }
                },
                child: Text(PPDateTime.toEuroString(viewmodel.endDate)),
              ),
              FlatButton(
                onPressed: () {
                  onGetContracts(viewmodel);
                },
                child: Text('GET'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> _showDatePicker({DateTime initialDate}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2012, 1),
        lastDate: DateTime.now());
    return picked;
  }

  void onGetContracts(SidebarViewModel viewmodel) async {
    Navigator.pop(context);
    final result = await widget.onTap(viewmodel.startDate, viewmodel.endDate);
    if (result == false) {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: [
            Center(
              child: Text('error'),
            ),
          ],
        ),
      );
    }
  }
}
