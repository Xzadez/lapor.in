import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title20ExtraBoldInter => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w800,
        fontFamily: 'Inter',
        color: appTheme.white_A700,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14RegularInter => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: appTheme.white_A700,
      );

  TextStyle get body14BoldInter => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        color: appTheme.white_A700,
      );

  TextStyle get body14SemiBoldInter => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label11RegularInter => TextStyle(
        fontSize: 11.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      );
}
