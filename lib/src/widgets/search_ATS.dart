import 'package:flutter/material.dart';

class SearchATSWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchATSWidget({Key? key, required this.text, required this.onChanged, required this.hintText}) : super(key: key);

  @override
  _SearchATSWidgetState createState() => _SearchATSWidgetState();
}

class _SearchATSWidgetState extends State<SearchATSWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      style: style,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.text.isNotEmpty ? GestureDetector(
          child: Icon(Icons.close, color: style.color),
          onTap: () {
            controller.clear();
            widget.onChanged('');
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ) : null,
        hintText: widget.hintText,
        hintStyle: style
      ),
    );
  }
}