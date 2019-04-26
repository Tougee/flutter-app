import 'package:flutter/widgets.dart';

const Color colorBlue = Color(0xff46a1ff);
const Color colorBlueDark = Color(0xff234afe);
const Color colorYellow = Color(0xffffb952);
const Color colorYellowDark = Color(0xffffa02e);
const Color colorPurple = Color(0xff9c62ff);
const Color colorPurpleDark = Color(0xff5b24fc);

class PercentPainter extends CustomPainter {

  List<double> percents;
  PercentPainter(List<double> percents) : super() {
    this.percents = percents;
  }

  List<Color> getColors() {
    int len = percents.length;
    if (len == 1) {
      return [colorBlue, colorBlueDark];
    } else if (len == 2) {
      return [colorBlue, colorBlueDark, colorYellow, colorYellowDark];
    } else {
      return [colorBlue, colorBlueDark, colorYellow, colorYellowDark, colorPurple, colorPurpleDark];
    }
  }

  List<double> getStops() {
    int len = percents.length;
    if (len == 1) {
      return [0, 1];
    } else if (len == 2) {
      return [0, percents[0], percents[0], percents[1]];
    } else {
      return [0, percents[0], percents[0] + 0.01, percents[0] + percents[1], percents[0] + percents[1] + 0.01, 1];
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (percents.length == 0) return;

    final rect = new Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = new LinearGradient(
      colors: getColors(),
      stops: getStops()
    );
    Paint paint = new Paint()
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}