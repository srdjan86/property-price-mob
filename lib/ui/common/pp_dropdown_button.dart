import 'package:flutter/material.dart';

class PPDropdownButton extends StatelessWidget {
  final int selectedItemId;
  final Function onChanged;
  final String hint;
  final List<dynamic> items;
  const PPDropdownButton(
      {Key key, this.selectedItemId, this.items, this.onChanged, this.hint})
      : super(key: key);

  List<DropdownMenuItem> _createItems() {
    return items
        .map((item) => DropdownMenuItem(
              child: Text(item.name),
              value: item.id,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    dynamic selectedItem = items.firstWhere(
      (element) => element.id == selectedItemId,
      orElse: () => null,
    );
    return DropdownButton(
      isExpanded: true,
      items: _createItems(),
      onChanged: this.onChanged,
      hint: Text(hint),
      value: selectedItem != null ? selectedItem.id : null,
    );
  }
}
