import 'dart:math';

import 'package:drawing/drawing_panel.dart';
import 'package:drawing/sketcher.dart';
import 'package:flutter/material.dart';

import 'drawn_line.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomeState();
}


List<Color> colors = [Colors.black, Colors.red, Colors.blue, Colors.yellow];
List<double> widths = [2, 3,4 ,5];

class _HomeState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      color: Colors.yellow[100],
      child: Stack(
        children: [
          // Add this
          buildCurrentPath(context),
        ],
      ),
    );
  }



  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: Sketcher(lines),
          ),
          // CustomPaint widget will go here
        ),
      ),
    );
  }

  DrawnLine line = DrawnLine([]);
  List<DrawnLine> lines = [DrawnLine([])];
  Color color = colors[Random().nextInt(3)];
  void onPanStart(DragStartDetails details) {
    print('User started drawing');
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState((){
      line = DrawnLine([point], selectedColor: color);
      lines.last = line;
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final Offset point = box.globalToLocal(details.globalPosition);
    final List<Offset> path = List.from(line.path)..add(point);
    setState((){
      line = DrawnLine(path, selectedColor: color);
      lines.last = line;
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      lines.add(line);
    });
    color = colors[Random().nextInt(4)];
  }
}
