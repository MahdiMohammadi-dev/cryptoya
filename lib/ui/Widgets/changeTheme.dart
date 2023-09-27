import 'package:cryptoya/providers/themeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);

    var changeIconTheme = Icon(themeprovider.isDarkMode
        ? CupertinoIcons.moon_fill
        : CupertinoIcons.sun_min_fill);

    return IconButton(
        onPressed: () {
          themeprovider.toggleTheme();
        },
        icon: changeIconTheme);
  }
}
