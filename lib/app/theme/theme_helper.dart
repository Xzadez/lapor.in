import 'package:flutter/material.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = "lightCode";

  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get white_A700 => Color(0xFFFFFFFF);
  Color get red_A700 => Color(0xFFFF0000);
  Color get blue_gray_100 => Color(0xFFD9D9D9);
  Color get black_900 => Color(0xFF000000);
  Color get blue_gray_200 => Color(0xFFABBBD2);
  Color get indigo_400_e5 => Color(0xE55880B5);

  // Additional Colors
  Color get transparentCustom => Colors.transparent;
  Color get greenCustom => Colors.green;
  Color get whiteCustom => Colors.white;
  Color get redCustom => Colors.red;
  Color get blueCustom => Colors.blue;
  Color get greyCustom => Colors.grey;
  Color get colorB5E558 => Color(0xB5E55880);
  Color get color47D9D9 => Color(0x47D9D9D9);
  Color get colorB7FF00 => Color(0xB7FF0000);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
