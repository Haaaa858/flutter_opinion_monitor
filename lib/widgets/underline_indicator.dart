import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///下划线指示器
class UnderlineIndicator extends Decoration {
  const UnderlineIndicator({
    this.strokeCap = StrokeCap.round,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  });
  final StrokeCap strokeCap;
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineIndicator) {
      return UnderlineIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is UnderlineIndicator) {
      return UnderlineIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this.strokeCap, this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.strokeCap, this.decoration, VoidCallback? onChanged)
      : super(onChanged);
  final StrokeCap strokeCap;
  final UnderlineIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left,
      indicator.bottom - borderSide.width,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = strokeCap;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
