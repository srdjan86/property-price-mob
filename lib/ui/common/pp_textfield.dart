import 'package:flutter/material.dart';

class PPTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final int maxLength;
  PPTextField({Key key, this.controller, this.label, this.maxLength})
      : super(key: key);

  @override
  _PPTextFieldState createState() => _PPTextFieldState();
}

class _PPTextFieldState extends State<PPTextField> {
  Function listener;
  @override
  void initState() {
    listener = () {
      setState(() {});
    };
    print('init state ${widget.controller.text}');
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('tf build');
    return Container(
      width: 120,
      child: Stack(children: [
        TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.label,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            maxLength: widget.maxLength),
        widget.controller.text.isNotEmpty
            ? Positioned(
                top: 14,
                right: 0,
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: widget.controller.clear,
                ),
              )
            : Container()
      ]),
    );
  }

  @override
  void dispose() {
    print('dispose');
    widget.controller.removeListener(listener);
    super.dispose();
  }
}
