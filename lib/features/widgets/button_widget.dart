import 'package:flutter/material.dart';

class ButtonGeneric extends StatelessWidget {
  const ButtonGeneric({
    super.key,
    required this.label,
    this.onPressed,
    this.labelStyle,
  });

  final String label;

  final void Function()? onPressed;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return ButtonTheme(
      minWidth: 200,
      height: 50,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: themeData.colorScheme.primary),
        ),
        color: themeData.colorScheme.primaryContainer,
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ).merge(labelStyle),
        ),
      ),
    );
  }
}
