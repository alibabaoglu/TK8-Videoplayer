import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_example/src/video/video.dart';
import 'package:video_player/video_player.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar(
    this.controller, {
    Key? key,
    required this.barHeight,
    required this.isPortrait,
    required this.circleSize,
  }) : super(key: key);
  final VideoPlayerController controller;
  final double barHeight;
  final double circleSize;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VideoCubit>(context);

    return Container(
      padding: EdgeInsets.zero,
      height: 10,
      width: isPortrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width - 300,
      color: Colors.transparent,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails details) {
          controller.setVolume(0.0);

          if (controller.value.isInitialized) {
            return;
          }

          if (controller.value.isPlaying) {
            controller.pause();
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (!controller.value.isInitialized) {
            return;
          }
          cubit.seekToRelativePosition(context, details.localPosition);
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          if (controller.value.isPlaying) {
            controller.play();
          }

          controller.setVolume(1.0);
        },
        onTapDown: (TapDownDetails details) {
          if (!controller.value.isInitialized) {
            return;
          }
          cubit.seekToRelativePosition(context, details.localPosition);
        },
        child: CustomPaint(
            painter: ProgressbarPainter(
              value: controller.value,
              height: barHeight,
              circleSize: circleSize,
            ),
            size: Size(MediaQuery.of(context).size.width, 10)),
      ),
    );
  }
}

class ProgressbarPainter extends CustomPainter {
  ProgressbarPainter({
    required this.value,
    required this.height,
    required this.circleSize,
  });
  VideoPlayerValue value;
  double height;
  double circleSize;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);

    final double playedPartPercent =
        value.position.inMilliseconds / value.duration.inMilliseconds;

    final basePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = height;
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), basePaint);

    final buffered = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = height;
    for (final DurationRange range in value.buffered) {
      final double start = range.startFraction(value.duration) * size.width;
      final double end = range.endFraction(value.duration) * size.width;
      canvas.drawLine(Offset(start, 0), Offset(end, 0), buffered);
    }
    final double playedPart =
        playedPartPercent > 1 ? size.width : playedPartPercent * size.width;

    final barPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.5;
    canvas.drawLine(Offset(0, 0), Offset(playedPart, 0), barPaint);

    final thumbPaint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(playedPart, -1), circleSize, thumbPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
