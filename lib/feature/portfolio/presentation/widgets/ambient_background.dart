import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:portofolio/core/constants/app_colors.dart';

/// Decorative layered background for the full portfolio page.
class AmbientBackground extends StatelessWidget {
  /// Creates the background.
  const AmbientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: const [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B0F14),
                  Color(0xFF0F141C),
                  Color(0xFF0B0F14),
                ],
              ),
            ),
          ),
          _GlowOrb(
            alignment: Alignment(-0.95, -0.72),
            size: 340,
            color: Color(0x3348E5C2),
          ),
          _GlowOrb(
            alignment: Alignment(1.0, -0.1),
            size: 360,
            color: Color(0x2254A9FF),
          ),
          _GlowOrb(
            alignment: Alignment(-0.25, 0.8),
            size: 300,
            color: Color(0x145FFFF0),
          ),
          _NoiseLayer(),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.alignment,
    required this.size,
    required this.color,
  });

  final Alignment alignment;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

class _NoiseLayer extends StatelessWidget {
  const _NoiseLayer();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NoisePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryText.withValues(alpha: 0.025);
    final random = math.Random(7);

    for (var index = 0; index < 260; index++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.2 + 0.2;

      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
