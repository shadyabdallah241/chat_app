import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  const AppTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPasswordHidden = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword && isPasswordHidden,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primary),
          ),
          filled: true,
          fillColor: theme.secondary,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: theme.primary),

          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  child: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                    color: theme.primary,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
