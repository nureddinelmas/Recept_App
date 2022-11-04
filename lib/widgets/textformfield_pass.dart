import 'package:flutter/material.dart';

class TextFormFieldPass extends StatefulWidget {
  TextFormFieldPass(this.passController, this.passwordIsHidden, {super.key});

  final TextEditingController passController;
  bool passwordIsHidden;

  @override
  State<TextFormFieldPass> createState() => _TextFormFieldPassState();
}

class _TextFormFieldPassState extends State<TextFormFieldPass> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: !widget.passwordIsHidden,
        controller: widget.passController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(widget.passwordIsHidden
                ? Icons.visibility
                : Icons.visibility_off),
            color: widget.passwordIsHidden ? Colors.green : Colors.grey,
            onPressed: () {
              setState(() {
                widget.passwordIsHidden = !widget.passwordIsHidden;
              });
            },
          ),
        ),
      ),
    );
  }
}
