import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:timetracking/constants/app_const.dart';
import 'package:timetracking/utils/util.dart';

class ColorSelectWidget extends StatelessWidget {
  final int? selected;
  final Function(Color c)? onColorsChange;
  const ColorSelectWidget(
      {super.key, required this.selected, this.onColorsChange});

  @override
  Widget build(BuildContext context) {
    late Color color;
    if (selected != null) {
      color = Color(selected!);
    } else {
      color = AppConst.defaultColors[0];
    }
    var themeData = Theme.of(context);

    return Row(children: [
      ...AppConst.defaultColors.map(
        (e) {
          var selected = e == color;
          return GestureDetector(
            onTap: () {
              color = e;
              if (onColorsChange != null) {
                onColorsChange!(e);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: selected ? color : e.withOpacity(.8),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: selected
                      ? themeData.primaryColorLight
                      : Colors.transparent,
                ),
              ),
            ),
          );
        },
      ).toList(),
      GestureDetector(
        onTap: () {
          _showColorPicker(context, pickerColor: color).then((c) {
            if (onColorsChange != null) {
              color = c;
              onColorsChange!(c);
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: themeData.primaryColorLight),
          ),
          child: const Icon(Icons.colorize_outlined),
        ),
      ),
    ]);
  }
}

Future<Color> _showColorPicker(BuildContext context,
    {Color? pickerColor}) async {
  Color c = Colors.green;
  await showbtmSheet(
    context,
    ColorPicker(
      pickerColor: pickerColor ?? c,
      onColorChanged: (color) {
        c = color;
      },
    ),
  );

  return c;
}
