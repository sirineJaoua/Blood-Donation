import 'package:flutter/material.dart';

class ButtonT extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const ButtonT({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(150, 40),
        primary: Colors.red[900],
        onPrimary: Colors.white,
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
