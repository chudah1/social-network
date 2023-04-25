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
/// This function returns a container with a sized text form field widget that has various properties
/// and functions assigned to it.
/// 
/// Args:
///   context (BuildContext): The BuildContext is a handle to the location of a widget in the widget
/// tree. It is used by the framework to locate and update the widget in the tree. It is passed as a
/// parameter to the build() method of a widget.
/// 
/// Returns:
///   A Container widget containing a TextFormField widget with various properties such as height,
/// width, decoration, and validation. The TextFormField widget also has an onTap function that is
/// passed from the parent widget through the onTap property.
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
