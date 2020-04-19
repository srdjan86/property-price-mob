import 'package:flutter/material.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:property_price_mob/ui/base/base_widget.dart';
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
    final viewmodel = SidebarViewModel(Provider.of(context));
    viewmodel.init();
    return BaseWidget<SidebarViewModel>(
      viewModel: viewmodel,
      enableLoading: true,
      builder: (context, viewModel, child) => Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                PPDropdownButton(
                  items: viewModel.districts,
                  onChanged: (value) {
                    viewModel.setSelectedDistrict(value);
                  },
                  value: viewModel.selectedDistrict,
                  hint: 'District',
                ),
                PPDropdownButton(
                  items: viewModel.cadasterDistricts,
                  onChanged: (value) {
                    viewModel.setSelectedCadesterDistrict(value);
                  },
                  value: viewModel.selectedCadesterDistrict,
                  hint: 'Cadester District',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
