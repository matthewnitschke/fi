import 'package:flutter/material.dart';

class AutoFocusTextField extends StatefulWidget {
  String? initialValue;
  void Function(String) onChanged;
  InputDecoration? decoration;
  TextInputType? keyboardType;

  AutoFocusTextField({ Key? key, this.initialValue, this.keyboardType, this.decoration, required this.onChanged  }) : super(key: key);

  @override
  _AutoFocusTextFieldState createState() => _AutoFocusTextFieldState();
}

class _AutoFocusTextFieldState extends State<AutoFocusTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: () => _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.value.text.length),
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
    );
  }
}