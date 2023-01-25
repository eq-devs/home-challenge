import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String? str;
  final VoidCallback onTap;
  final String labelText;
  final TextStyle? style;
  final double? maxHeight;
  const InputWidget(
      {super.key,
      this.style,
      required this.labelText,
      required this.onTap,
      required this.str,
      this.maxHeight});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();

    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap,
      child: InputDecorator(
        isEmpty: false,
        isFocused: false,
        isHovering: false,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: widget.maxHeight ?? 100),
          fillColor: null,
          isDense: true,
          enabled: false,
          labelText: widget.labelText,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: themeData.dividerColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: themeData.dividerColor),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Scrollbar(
          key: ValueKey(widget.str),
          interactive: false,
          radius: const Radius.circular(20),
          thickness: 2,
          controller: controller,
          thumbVisibility: controller.hasClients,
          child: SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: Text(widget.str ?? '',
                style: widget.style ??
                    themeData.textTheme.headline5?.copyWith(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
