import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFiledWidget extends StatefulWidget {
  const TextFiledWidget(
      {Key? key,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.onEditingCompleted,
      this.keyboardType,
      this.onChanged,
      this.isMulti,
      this.autofocus,
      this.enabled,
      this.errorText,
      this.label,
      this.suffix,
      this.prefix,
      this.hintText,
      this.prefixIcon,
      this.focusNode,
      this.onFieldSubmitted,
      this.vertical = 0,
      this.inputFormatters,
      this.autocorrect = false,
      this.style,
      this.textInputAction,
      this.textAlign = TextAlign.left,
      this.maxLength,
      this.expands = false,
      this.maxLines,
      this.mustValidate})
      : super(key: key);
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final double vertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final bool expands;
  final int? maxLines;
  final bool? mustValidate;
  @override
  State<TextFiledWidget> createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  final TextEditingController controller = TextEditingController();
  late ValueNotifier<bool> clearIcon;
  @override
  void initState() {
    super.initState();
    clearIcon = ValueNotifier(false);
  }

  @override
  void dispose() {
    controller.dispose();
    clearIcon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(15.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          TextFormField(
              focusNode: widget.focusNode,
              controller: controller,
              style: widget.style,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              onSaved: (s) {
                controller.clear();
              },
              inputFormatters: widget.inputFormatters,
              onFieldSubmitted: widget.onFieldSubmitted,
              autocorrect: widget.autocorrect,
              textAlign: widget.textAlign,
              onChanged: (str) {
                if (str.isNotEmpty) {
                  clearIcon.value = true;
                  if (widget.onChanged != null) widget.onChanged!(str);
                } else {
                  clearIcon.value = false;
                }
              },
              onEditingComplete: widget.onEditingCompleted,
              autofocus: widget.autofocus ?? false,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide()),
                  errorStyle: const TextStyle(height: .01),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  filled: true,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon),
              onTap: widget.onTap,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              validator: (str) {
                if (str!.isEmpty) {
                  return "";
                } else {
                  return null;
                }
              }),
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: clearIcon,
                      builder: (context, value, child) => value
                          ? _clearBtn(() {
                              controller.text = '';
                              controller.clear();

                              clearIcon.value = false;
                            })
                          : const SizedBox()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell _clearBtn(VoidCallback onTap) {
    return InkWell(onTap: onTap, child: const Icon(Icons.clear));
  }
}
