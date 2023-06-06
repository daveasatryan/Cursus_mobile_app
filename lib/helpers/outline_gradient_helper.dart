import 'package:flutter/material.dart';

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final double _radius;

  UnicornOutlineButton({
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    Key? key,
  })  : _painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _child = child,
        _radius = radius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          minHeight: 50,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _child,
          ],
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : strokeWidth = strokeWidth,
        radius = radius,
        gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    final outerRect = Offset.zero & size;
    final outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    final innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    final innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    final path1 = Path()..addRRect(outerRRect);
    final path2 = Path()..addRRect(innerRRect);
    final path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
