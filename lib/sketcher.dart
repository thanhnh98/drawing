import 'dart:math';

import 'package:drawing/drawn_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sketcher extends CustomPainter {
  List<DrawnLine> lines;
  Sketcher(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; ++i) {
      DrawnLine line = lines[i];
      drawLine(line, canvas);
    }
  }

  void drawLine(DrawnLine line, Canvas canvas){
    Paint paint = Paint();

    paint.color = line.selectedColor;
    paint.strokeWidth = line.selectedWidth;
    paint.style = PaintingStyle.stroke;

    if(line.path.length > 1){
      for (int i =0; i < line.path.length - 1; ++i){
        canvas.drawLine(line.path[i], line.path[i+1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

}