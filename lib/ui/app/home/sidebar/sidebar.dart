import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:property_price_mob/ui/common/pp_textfield.dart';
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
    FocusScopeNode currentFocus = FocusScope.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // PPDropdownButton(
            //   items: viewmodel.districts,
            //   onChanged: (value) {
            //     viewmodel.setSelectedDistrict(value);
            //   },
            //   value: viewmodel.selectedDistrict,
            //   hint: 'District',
            // ),
            // PPDropdownButton(
            //   items: viewmodel.cadasterDistricts,
            //   onChanged: (value) {
            //     viewmodel.setSelectedCadesterDistrict(value);
            //   },
            //   value: viewmodel.selectedCadesterDistrict,
            //   hint: 'Cadester District',
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 120,
                  child: GestureDetector(
                    onTap: () async {
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
                    child: AbsorbPointer(
                      child: TextField(
                        readOnly: true,
                        controller: viewmodel.startDateController,
                        decoration: InputDecoration(labelText: 'Start date'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: GestureDetector(
                    onTap: () async {
                      final date = await _showDatePicker(
                        initialDate: viewmodel.endDate,
                      );
                      if (date != null) {
                        viewmodel.endDate = date;
                        if (date.isBefore(viewmodel.startDate)) {
                          viewmodel.startDate = date;
                        }
                      }
                      currentFocus.unfocus();
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        readOnly: true,
                        controller: viewmodel.endDateController,
                        decoration: InputDecoration(labelText: 'End date'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: ExpansionTile(
                initiallyExpanded: viewmodel.expanded,
                onExpansionChanged: (value) {
                  viewmodel.expanded = value;
                },
                backgroundColor: Colors.grey[200],
                // leading: Text('Filters'),
                title: Text('Filters'),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PPTextField(
                        controller: viewmodel.minPriceController,
                        maxLength: 7,
                        label: 'Min price',
                      ),
                      SizedBox(width: 30),
                      PPTextField(
                        controller: viewmodel.maxPriceController,
                        maxLength: 7,
                        label: 'Max price',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      PPTextField(
                        controller: viewmodel.minSizeController,
                        maxLength: 7,
                        label: 'Min size',
                      ),
                      SizedBox(width: 30),
                      PPTextField(
                        controller: viewmodel.maxSizeController,
                        maxLength: 7,
                        label: 'Max size',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
            FlatButton(
              onPressed: () {
                onGetContracts(viewmodel);
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Apply',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
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
    HomeViewModel homeViewmodel = Provider.of(context, listen: false);
    final scafoldContext = Scaffold.of(context).context;
    Navigator.pop(context);
    final request = viewmodel.createFilters();
    final result = await widget.onTap(request);
    if (result == false) {
      showNotificationDialog(
          context: scafoldContext, text: homeViewmodel.error);
    } else {
      if (homeViewmodel.contracts.length == 0) {
        showNotificationDialog(context: scafoldContext, text: 'No result');
      }
    }
  }

  void showNotificationDialog({BuildContext context, String text}) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          Center(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
