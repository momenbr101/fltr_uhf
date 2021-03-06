import 'package:flutter/material.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({this.title, @required this.onChanged});

  final Function onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: title,
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        ),
      ),
    );
  }
}
