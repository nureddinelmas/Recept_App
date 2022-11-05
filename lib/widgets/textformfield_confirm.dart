import 'package:flutter/material.dart';

class TextFormFieldConfirmPass extends StatefulWidget {
  TextFormFieldConfirmPass(this.confirmController, this.confirmPasswordIsHidden,
      {super.key});

  final TextEditingController confirmController;
  bool confirmPasswordIsHidden;

  @override
  State<TextFormFieldConfirmPass> createState() =>
      _TextFormFieldConfirmPassState();
}

class _TextFormFieldConfirmPassState extends State<TextFormFieldConfirmPass> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: !widget.confirmPasswordIsHidden,
        controller: widget.confirmController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(widget.confirmPasswordIsHidden
                ? Icons.visibility
                : Icons.visibility_off),
            color: widget.confirmPasswordIsHidden ? Colors.green : Colors.grey,
            onPressed: () {
              setState(() {
                widget.confirmPasswordIsHidden =
                    !widget.confirmPasswordIsHidden;
              });
            },
          ),
        ),
      ),
    );
  }
}
