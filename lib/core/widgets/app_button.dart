import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const AppButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: theme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text, style: TextStyle())),
      ),
    );
  }
}
