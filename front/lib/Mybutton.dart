import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const Mybutton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          primary: Colors.red[900],
          backgroundColor: Color.fromARGB(255, 158, 158, 158)),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
