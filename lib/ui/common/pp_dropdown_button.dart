import 'package:flutter/material.dart';
import 'package:property_price_mob/model/district.dart';

class PPDropdownButton extends StatelessWidget {
  final String value;
  final List<District> items;
  final Function onChanged;
  final String hint;
  const PPDropdownButton(
      {Key key, this.value, this.items, this.onChanged, this.hint})
      : super(key: key);

  List<DropdownMenuItem> _createItems() {
    return items
        .map((item) => DropdownMenuItem(
              child: Text(item.name),
              value: item.value,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: _createItems(),
      onChanged: this.onChanged,
      hint: Text(hint),
      value: value,
    );
  }
}
