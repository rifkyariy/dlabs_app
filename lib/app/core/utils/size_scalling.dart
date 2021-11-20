import 'dart:math';

import 'package:flutter/material.dart';

enum SizeScallingOrientation {
  SizeScallingOrientation_Landscape,
  SizeScallingOrientation_potrait,
  SizeScallingOrientation_unset
}

class SizeScalling {
  static double _screenWidth = 1,
      _screenHight = 1,
      _drawingWidth = 1,
      _drawingHeight = 1;
  static double _scalingText = 1, _scalingWidth = 1, _scalingHeight = 1;
  static const Size drawingSizeDefault = Size(360, 700);
  static late SizeScalling _instance;

  SizeScalling._();

  factory SizeScalling() {
    return _instance;
  }

  double get scaleWidth => _scalingWidth;
  double get scaleHeight => _scalingHeight;
  double get scaleText => _scalingText;

  static void init(BuildContext context,
      {Size drawingSize = drawingSizeDefault,
      SizeScallingOrientation orien =
          SizeScallingOrientation.SizeScallingOrientation_potrait}) {
    _drawingWidth = drawingSize.width;
    _drawingHeight = drawingSize.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHight = MediaQuery.of(context).size.height;

    _scalingWidth = _screenWidth / _drawingWidth;
    _scalingHeight = _screenHight / _drawingHeight;
    _instance = SizeScalling._();
    _scalingText =
        orien == SizeScallingOrientation.SizeScallingOrientation_Landscape
            ? _scalingHeight
            : _scalingWidth;
  }

  double get textScaleFactor => _scalingText;
  double get scalingWidth => _scalingWidth;
  double get scalingHeight => _scalingHeight;

  double setHeight(double height) => height * scalingHeight;
  double setWidth(double width) => width * scalingWidth;
  double setRadius(double r) => textScaleFactor * r;
  double setSp(double sp) => textScaleFactor * sp;
}
