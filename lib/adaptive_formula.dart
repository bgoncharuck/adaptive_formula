library adaptive_formula;

import 'package:flutter/material.dart';

const _defaultFigmaScreenSize = Size(375, 812);

void adaptiveFormulaInitFromBuildContext({
  required BuildContext context,
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) =>
    adaptiveFormulaInitFromSize(
      deviceScreenSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      figmaScreenSize: figmaScreenSize,
    );

void adaptiveFormulaInitFromSize({
  required Size deviceScreenSize,
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) {
  _figmaScreenWidth = figmaScreenSize.width;
  _figmaScreenHeight = figmaScreenSize.height;
  _deviceScreenWidth = deviceScreenSize.width;
  _deviceScreenHeight = deviceScreenSize.height;
}

late double _deviceScreenWidth;
late double _deviceScreenHeight;
late double _figmaScreenWidth;
late double _figmaScreenHeight;

double adaptiveHeight(double elementHeight, {double? screenHeight}) =>
    (screenHeight ?? _deviceScreenHeight) * elementHeight / _figmaScreenHeight;
double adaptiveWidth(double elementWidth, {double? screenWidth}) =>
    (screenWidth ?? _deviceScreenWidth) * elementWidth / _figmaScreenWidth;
double adaptiveFontSize(TextStyle textStyle, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) * textStyle.fontSize! / _figmaScreenWidth).floor().toDouble();
double adaptiveFontSizeRaw(double fontSize, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) * fontSize / _figmaScreenWidth).floor().toDouble();
TextStyle adaptiveTextStyle(TextStyle textStyle, {double? screenWidth}) => textStyle.copyWith(
    fontSize: ((screenWidth ?? _deviceScreenWidth) * textStyle.fontSize! / _figmaScreenWidth).floor().toDouble());
