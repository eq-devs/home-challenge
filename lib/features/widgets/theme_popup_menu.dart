import 'package:flutter/material.dart';
import 'package:timetracking/constants/app_color.dart';

class ThemePopupMenu extends StatelessWidget {
  const ThemePopupMenu({
    super.key,
    required this.schemeIndex,
    required this.onChanged,
    this.contentPadding,
  });
  final int schemeIndex;
  final ValueChanged<int> onChanged;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;

    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tooltip: '',
      padding: EdgeInsets.zero,
      onSelected: onChanged,
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        for (int i = 0; i < AppColor.customSchemes.length; i++)
          PopupMenuItem<int>(
            value: i,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              dense: true,
              leading: Icon(Icons.lens,
                  color: isLight
                      ? AppColor.customSchemes[i].light.primary
                      : AppColor.customSchemes[i].dark.primary,
                  size: 35),
              title: Text(AppColor.customSchemes[i].name),
            ),
          )
      ],
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          '${AppColor.customSchemes[schemeIndex].name} color scheme',
        ),
        subtitle: Text(AppColor.customSchemes[schemeIndex].description),
        trailing: const CircleAvatar(
          child: Icon(
            Icons.colorize_outlined,
          ),
        ),
      ),
    );
  }
}
