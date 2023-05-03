import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(150, 40),
        primary: Colors.white,
        backgroundColor: Colors.red[900],
        elevation: 10,
        shadowColor: Colors.red,
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
