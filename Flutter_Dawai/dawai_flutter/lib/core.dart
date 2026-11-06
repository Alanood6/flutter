import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

// ================= COLORS =================

class C {
  static const dark = Color(0xFF241632);
  static const deep = Color(0xFF35204D);
  static const purple = Color(0xFF7652A8);
  static const violet = Color(0xFF9875C6);
  static const lavender = Color(0xFFD9C8EF);
}

// ================= USERS LIST =================

class UserAccount {
  final String name;
  final String email;
  final String phone;
  final String password;

  UserAccount({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

// Users exist only while the app is running.
final List<UserAccount> usersList = [];

// ================= BACKGROUND =================

class LuxuryBackground extends StatelessWidget {
  const LuxuryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF241632),
            Color(0xFF38234F),
            Color(0xFF50346D),
            Color(0xFF2B1B40),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: _glow(300, const Color(0xFFB99ADB)),
          ),
          Positioned(
            bottom: -130,
            left: -90,
            child: _glow(320, const Color(0xFF9875C6)),
          ),
          Positioned(
            top: 350,
            right: 100,
            child: _glow(180, const Color(0xFF8060A8)),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.20),
            blurRadius: 110,
            spreadRadius: 35,
          ),
        ],
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double progress;

  ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint();

    for (int i = 0; i < 40; i++) {
      final x = (i * 73.0) % size.width;
      final y = (i * 113.0 + progress * 180) % size.height;
      final opacity =
          0.08 + (math.sin(progress * 2 * math.pi + i) + 1) * 0.12;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(
        Offset(x, y),
        1.2 + (i % 3) * 0.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ================= UI HELPERS =================

InputDecoration fieldDecoration(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color(0xFFD0C3DC),
      fontSize: 14,
    ),
    prefixIcon: Icon(icon, color: C.lavender),
    filled: true,
    fillColor: Colors.white.withOpacity(0.09),
    contentPadding: const EdgeInsets.all(18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: C.lavender, width: 1.5),
    ),
  );
}

Widget glassCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      child: Container(
        padding: const EdgeInsets.all(23),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.085),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
        ),
        child: child,
      ),
    ),
  );
}

Widget gradientButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 58,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBDA2DC), Color(0xFF8060AA)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: C.violet.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

// ================= CAPSULE LOGO =================

// Default logo used on splash and login.
Widget logo({double size = 65}) {
  return SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: CapsulePainter(openProgress: 0),
    ),
  );
}

// Animated opening logo used only on Register screen.
class OpeningCapsule extends StatefulWidget {
  final double size;

  const OpeningCapsule({super.key, this.size = 65});

  @override
  State<OpeningCapsule> createState() => _OpeningCapsuleState();
}

class _OpeningCapsuleState extends State<OpeningCapsule>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return CustomPaint(
            painter: CapsulePainter(openProgress: controller.value),
          );
        },
      ),
    );
  }
}

class CapsulePainter extends CustomPainter {
  final double openProgress;

  CapsulePainter({required this.openProgress});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-math.pi / 4);

    final w = size.width * 0.42;
    final h = size.height * 0.88;
    final separation = h * 0.22 * openProgress;

    final fullRect = Rect.fromCenter(
      center: Offset.zero,
      width: w,
      height: h,
    );

    final purplePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB99ADB), Color(0xFF7652A8)],
      ).createShader(fullRect);

    final whitePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Color(0xFFE8DDF5)],
      ).createShader(fullRect);

    final purpleRect = Rect.fromLTRB(
      -w / 2,
      -h / 2 - separation,
      w / 2,
      separation * 0.05,
    );

    final whiteRect = Rect.fromLTRB(
      -w / 2,
      -separation * 0.05,
      w / 2,
      h / 2 + separation,
    );

    final purplePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          purpleRect,
          Radius.circular(w / 2),
        ),
      );

    final whitePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          whiteRect,
          Radius.circular(w / 2),
        ),
      );

    canvas.drawShadow(
      purplePath,
      Colors.black.withOpacity(0.35),
      7,
      true,
    );
    canvas.drawShadow(
      whitePath,
      Colors.black.withOpacity(0.35),
      7,
      true,
    );

    canvas.drawPath(purplePath, purplePaint);
    canvas.drawPath(whitePath, whitePaint);

    final border = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    canvas.drawPath(purplePath, border);
    canvas.drawPath(whitePath, border);

    // A few tiny glowing particles appear between the capsule halves.
    if (openProgress > 0.15) {
      final particlePaint = Paint()
        ..color = C.lavender.withOpacity(openProgress);

      for (int i = 0; i < 3; i++) {
        canvas.drawCircle(
          Offset(0, (i - 1) * h * 0.12),
          w * 0.06,
          particlePaint,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CapsulePainter oldDelegate) {
    return oldDelegate.openProgress != openProgress;
  }
}

