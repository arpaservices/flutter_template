import 'package:flutter/material.dart';

class CircleTextWrapper extends StatelessWidget {
  const CircleTextWrapper({
    Key? key,
    this.radius = 110,
    this.text =
    "",
    this.textStyle = const TextStyle(fontSize: 20),
    this.startAngle = 0,
  }) : super(key: key);
  final double radius;
  final String text;
  final double startAngle;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) => Container(
    width: radius*2,
    child: CustomPaint(
      painter: _Painter(
        radius,
        text,
        textStyle,
      ),
    ),
  );
}

class _Painter extends CustomPainter {
  _Painter(this.radius, this.text, this.textStyle, {this.padding = 12});
  final double radius;
  final String text;
  final double padding;

  final TextStyle textStyle;
  final _textPainter = TextPainter(textDirection: TextDirection.ltr);
  final Paint _paint = Paint()
    ..blendMode
    ..color = secondarydark
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset.zero, radius + padding, _paint);


    _textPainter.text = TextSpan(text: text, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: size.width - padding * 2,
    );

    final double y = -_textPainter.height / 2;
    final double x = -_textPainter.width / 2;

    _textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}