import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:raxii_desktop/app/theme/app_colors.dart';

class BackgroundPainter extends StatefulWidget {
  const BackgroundPainter({Key? key}) : super(key: key);

  @override
  State<BackgroundPainter> createState() => _BackgroundPainterState();
}

class _BackgroundPainterState extends State<BackgroundPainter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final List<DataLine> _dataLines = [];
  final Random _random = Random();

  final int numParticles = 300;
  final Color bgColor = AppColors.deepForestGreen;
  final Color accentColor = AppColors.primary;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numParticles; i++) {
      _particles.add(Particle.random(_random));
    }

    for (int i = 0; i < 5; i++) {
      _dataLines.add(DataLine.generate(_random));
    }

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1000))
          ..addListener(() {
            for (var p in _particles) {
              p.update();
            }
            setState(() {});
          })
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RaxiiPainter(
        particles: _particles,
        dataLines: _dataLines,
        accentColor: accentColor,
        bgColor: bgColor,
      ),
      child: Container(),
    );
  }
}

class DataLine {
  final List<Offset> points;
  final double strokeWidth;

  DataLine(this.points, this.strokeWidth);

  factory DataLine.generate(Random random) {
    final points = <Offset>[];
    Offset current = Offset(random.nextDouble() * 1920, random.nextDouble() * 1080);
    points.add(current);
    for (int i = 0; i < 10; i++) {
      current += Offset(random.nextDouble() * 300 - 150, random.nextDouble() * 300 - 150);
      points.add(current);
    }
    return DataLine(points, random.nextDouble() * 3 + 1);
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double size;
  Color color;

  Particle(this.position, this.velocity, this.size, this.color);

  factory Particle.random(Random random) {
    final pos = Offset(random.nextDouble() * 1920, random.nextDouble() * 1080);
    final vel = Offset((random.nextDouble() - 0.5) * 2, (random.nextDouble() - 0.5) * 2);
    final size = random.nextDouble() * 3 + 2;
    final color = Color.fromARGB(
      150,
      137 + random.nextInt(20) - 10,
      205 + random.nextInt(20) - 10,
      41 + random.nextInt(20) - 10,
    );
    return Particle(pos, vel, size, color);
  }

  void update() {
    position += velocity;
    if (position.dx < 0 || position.dx > 1920 || position.dy < 0 || position.dy > 1080) {
      position = Offset(Random().nextDouble() * 1920, Random().nextDouble() * 1080);
    }
  }
}

class RaxiiPainter extends CustomPainter {
  final List<Particle> particles;
  final List<DataLine> dataLines;
  final Color accentColor;
  final Color bgColor;

  RaxiiPainter({
    required this.particles,
    required this.dataLines,
    required this.accentColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = bgColor;
    canvas.drawRect(Offset.zero & size, bgPaint);

    for (var line in dataLines) {
      final paint = Paint()
        ..color = accentColor.withOpacity(0.1)
        ..strokeWidth = line.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawPoints(PointMode.polygon, line.points, paint);
    }

    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 