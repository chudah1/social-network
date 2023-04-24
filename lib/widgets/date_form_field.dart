import 'package:flutter/material.dart';

class CustomDateFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final Function(String?) onSaved;
  final Function(String?) validator;
  final Function() onTap;

  const CustomDateFormField(
      {required this.hintText,
      required this.prefixIcon,
      required this.onSaved,
      required this.validator,
      required this.onTap});

  @override
  _CustomDateFormFieldState createState() => _CustomDateFormFieldState();
}

class _CustomDateFormFieldState extends State<CustomDateFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: SizedBox(
          width: 250,
          child: TextFormField(
              onTap: widget.onTap,
              readOnly: true,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: Icon(widget.prefixIcon),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: widget.onSaved,
              validator: (value) {
                final errorMessage = widget.validator(value);
                return errorMessage == null ? null : errorMessage.toString();
              }),
        ));
  }
}
