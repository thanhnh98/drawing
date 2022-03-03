import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawnLine{
  List<Offset> path;
  Color selectedColor;
  double selectedWidth;

  DrawnLine(
    this.path,
  {
    this.selectedColor = Colors.black,
    this.selectedWidth = 6
  }
  );
}