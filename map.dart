part of 'main.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenHeading(
              eyebrow: 'LIVE MAP',
              title: 'Explore around you',
              subtitle: 'Traffic, nearby deals and smart stop suggestions.',
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E9EF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: const [
                    Positioned.fill(
                      child: CustomPaint(painter: MapPainter()),
                    ),
                    Positioned(
                      left: 34,
                      top: 54,
                      child: MapBubble(
                        icon: Icons.coffee_rounded,
                        text: '30%',
                        accent: Color(0xFF7968FF),
                      ),
                    ),
                    Positioned(
                      right: 34,
                      top: 158,
                      child: MapBubble(
                        icon: Icons.restaurant_rounded,
                        text: '20%',
                        accent: Color(0xFFFF8066),
                      ),
                    ),
                    Positioned(
                      left: 94,
                      bottom: 180,
                      child: MapBubble(
                        icon: Icons.icecream_rounded,
                        text: '2x1',
                        accent: Color(0xFFFF6EAC),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.15, -0.05),
                      child: UserLocation(),
                    ),
                    Align(
                      alignment: Alignment(0, 0.92),
                      child: MapRecommendationBar(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapBubble extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accent;

  const MapBubble({
    super.key,
    required this.icon,
    required this.text,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 19, color: accent),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF171822),
            ),
          ),
        ],
      ),
    );
  }
}

class UserLocation extends StatelessWidget {
  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF6D5DFB),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6D5DFB).withOpacity(0.28),
            blurRadius: 18,
          ),
        ],
      ),
      child: const Icon(
        Icons.navigation_rounded,
        color: Colors.white,
        size: 21,
      ),
    );
  }
}

class MapRecommendationBar extends StatelessWidget {
  const MapRecommendationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFF0EEFF),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFF6D5DFB),
            ),
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Best stop: Coffee Lab',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF171822),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '4 min away · saves ~18 min',
                  style: TextStyle(
                    color: Color(0xFF8A8C97),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 15),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  const MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFE7E9EF);
    canvas.drawRect(Offset.zero & size, bg);

    final building = Paint()..color = const Color(0xFFDDE0E8);
    final random = math.Random(42);

    for (int i = 0; i < 24; i++) {
      final w = 34 + random.nextDouble() * 58;
      final h = 26 + random.nextDouble() * 48;
      final x = random.nextDouble() * math.max(1, size.width - w);
      final y = random.nextDouble() * math.max(1, size.height - h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, w, h),
          const Radius.circular(9),
        ),
        building,
      );
    }

    final major = Paint()
      ..color = Colors.white
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final minor = Paint()
      ..color = Colors.white.withOpacity(0.86)
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(-20, size.height * 0.16),
      Offset(size.width + 20, size.height * 0.68),
      major,
    );
    canvas.drawLine(
      Offset(size.width * 0.14, -20),
      Offset(size.width * 0.68, size.height + 20),
      major,
    );
    canvas.drawLine(
      Offset(-10, size.height * 0.76),
      Offset(size.width + 10, size.height * 0.34),
      minor,
    );
    canvas.drawLine(
      Offset(size.width * 0.80, -10),
      Offset(size.width * 0.34, size.height + 10),
      minor,
    );

    final traffic = Paint()
      ..color = const Color(0xFFE65C68)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.30, size.height * 0.34),
      Offset(size.width * 0.63, size.height * 0.51),
      traffic,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

