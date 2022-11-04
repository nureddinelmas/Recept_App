import 'package:flutter/material.dart';

class TextFormFieldWidgetEmail extends StatelessWidget {
  const TextFormFieldWidgetEmail(this.emailController, {super.key});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: emailController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Email",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mail,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}
