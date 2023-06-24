import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simpledoughnutgraph/data_item_model.dart';

class DoughnutChartPainter extends CustomPainter {

  List<DataItemModel> dataItems = [];
final double fullAngle;
String? centerValue;
String? centerTitle;
Color centerPaintColor;
TextStyle centerValueTextStyle;
TextStyle centerTitleTextStyle;

DoughnutChartPainter({
  this.centerTitle,
  this.centerValue,
  required this.dataItems,
  required this.fullAngle,
  required this.centerPaintColor,
  required this.centerTitleTextStyle,
  required this.centerValueTextStyle,
});

int hoveredSectorIndex = -1;


  @override
  void paint(Canvas canvas, Size size, {List<Offset>? hoverPositions}) {

  double getStartAngle(int index) {
  // Calculate the start angle for the given index
  // ...
}

double getSweepAngle(int index) {
  // Calculate the sweep angle for the given index
  // ...
}

Rect getSectorRect(double startAngle, double sweepAngle) {
  // Calculate and return the Rect for the sector defined by startAngle and sweepAngle
  // ...
}

  int getHoveredSectorIndex(List<Offset> hoverPositions) {
  for (int i = 0; i < dataItems.length; i++) {
    final startAngle = getStartAngle(i);
    final sweepAngle = getSweepAngle(i);
    final rect = getSectorRect(startAngle, sweepAngle);
    
    for (final hoverPos in hoverPositions) {
      if (rect.contains(hoverPos)) {
        return i;
      }
    }
  }
  
  return -1; // No sector is hovered
}



    if(hoverPositions != null){
    // Check if the hover position is within any sector
    hoveredSectorIndex = getHoveredSectorIndex(hoverPositions);
  } else {
    hoveredSectorIndex = -1;
  }

    final centerPaint = Paint()
    ..color = centerPaintColor
    ..style = PaintingStyle.fill;

    final linePath = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);

    void drawLines(double radius, double startAngle, Offset c, Canvas canvas,
    Paint linePath) {
    final lineLength = radius / 2;
    final dx = lineLength * cos(startAngle);
    final dy = lineLength * sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePath);
    }

    

  void drawSectors(DataItemModel di, Canvas canvas, Rect rect, double startAngle,
      double sweepAngle) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = di.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

    var startAngle = 0.0;
    for (var di in dataItems) {
      final sweepAngle = di.value * fullAngle / 180 * pi;
      drawSectors(di, canvas, rect, startAngle, sweepAngle);
      startAngle += sweepAngle;
    }

    startAngle = 0.0;
    for (var di in dataItems) {
      final sweepAngle = di.value * fullAngle / 180 * pi;
      drawLines(radius, startAngle, c, canvas, linePath);
      startAngle += sweepAngle;
    }

     TextPainter measureText(String mainText,String subtitle, TextStyle maintextStyle,  TextStyle subtitletextStyle,   double maxWidth,
      TextAlign textAlign) {
    final span = TextSpan( children: [
      TextSpan(
        text: mainText + '\n',
        style: maintextStyle,
      ),
      TextSpan(
        text: subtitle,
        style: subtitletextStyle,
      )
    ]);
    final tp = TextPainter(
        text: span, textAlign: textAlign, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String maintext, String subtext,
      TextStyle maintextStyle, TextStyle subtextStyle, double maxWidth, Function(Size size) bgCb) {
    final textPainter =
        measureText(maintext, subtext, maintextStyle, subtextStyle, maxWidth, TextAlign.center);
    final pos =
        position + Offset(-textPainter.width / 2.0, -textPainter.height / 2.0);
    bgCb(textPainter.size);
    textPainter.paint(canvas, pos);
    return textPainter.size;
  }

    

    canvas.drawCircle(c, radius * 0.3, centerPaint);
    drawTextCentered(canvas, c, centerValue ?? '0', centerTitle ?? '', centerTitleTextStyle, centerTitleTextStyle,
        radius * 0.5, (Size sz) {});
  }
  
  

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}


