import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:property_price_mob/ui/common/pp_dropdown_button.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  Sidebar({Key key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    print('build sidebar');
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
            ],
          ),
        ),
      ),
    );
  }
}
