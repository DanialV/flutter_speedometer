import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'dart:math';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedometor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;


  double percentage;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.addListener((){
      setState(() {
        percentage = ((_controller.value * 180) *73) / 220;
      });
    });
    setState(() {
      percentage = 0;
    });
    _controller.forward();


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          height: 100.0,
          width: 100.0,
          child: new CustomPaint(
            foregroundPainter: new MyPainter(
                lineColor: Colors.black26,
                completeColor: Color.fromRGBO(255, 140, 0, 1),
                completePercent:percentage,
                width: 8.0
            ),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Stack(
                children: <Widget>[
                  new Image.asset("images/main3.png",width: 100,height: 100,),
                  Center(
                  child: new Text(
                    (_controller.value * 180).floor().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(254, 147, 1,1),

                        fontSize: 15
                    ),
                  ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}


class MyPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  MyPainter({this.lineColor,this.completeColor,this.completePercent,this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center  = new Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);
    canvas.drawCircle(
        center,
        radius,
        line
    );
    double arcAngle = 2*pi* (completePercent/100);
    canvas.drawArc(
        new Rect.fromCircle(center: center,radius: radius),
        pi/1.3,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
