import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool? hasLoading;

  const AppButton({
    super.key,
    this.onTap,
    required this.text,
    this.hasLoading = false,
  });

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
        child: Center(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: theme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              if (hasLoading == true) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
