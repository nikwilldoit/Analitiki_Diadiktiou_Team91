part of 'main.dart';

class TrafficScreen extends StatelessWidget {
  const TrafficScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 18, 20, 112),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenHeading(
              eyebrow: 'PREDICTIVE MODEL',
              title: 'Traffic intelligence',
              subtitle: 'See what is happening now and what the model expects next.',
            ),
            SizedBox(height: 20),
            Expanded(child: TrafficDashboard()),
          ],
        ),
      ),
    );
  }
}

class TrafficDashboard extends StatelessWidget {
  const TrafficDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        DarkPredictionPanel(),
        SizedBox(height: 22),
        SectionTitle(
          title: 'Nearby roads',
          subtitle: 'Predicted congestion around your current route',
        ),
        SizedBox(height: 12),
        TrafficRoadTile(
          name: 'Kifisias Avenue',
          status: 'Heavy',
          delay: '+24 min',
          value: 0.88,
          color: Color(0xFFE65C68),
        ),
        SizedBox(height: 10),
        TrafficRoadTile(
          name: 'Vasilissis Sofias',
          status: 'Moderate',
          delay: '+12 min',
          value: 0.58,
          color: Color(0xFFF0A449),
        ),
        SizedBox(height: 10),
        TrafficRoadTile(
          name: 'Alexandras Avenue',
          status: 'Low',
          delay: '+5 min',
          value: 0.26,
          color: Color(0xFF47B887),
        ),
        SizedBox(height: 22),
        TrendCard(),
      ],
    );
  }
}

class DarkPredictionPanel extends StatelessWidget {
  const DarkPredictionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF161720), Color(0xFF292A43)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: TrafficCurvePainter()),
          ),
          Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SoftBadge(
                  icon: Icons.query_stats_rounded,
                  label: 'NEXT 45 MINUTES',
                ),
                Spacer(),
                Text(
                  'Congestion should improve\ngradually',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    TimeForecastChip(label: 'Now', value: '88%'),
                    SizedBox(width: 8),
                    TimeForecastChip(label: '+20m', value: '61%'),
                    SizedBox(width: 8),
                    TimeForecastChip(label: '+40m', value: '33%'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeForecastChip extends StatelessWidget {
  final String label;
  final String value;

  const TimeForecastChip({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFADB0BE),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrafficRoadTile extends StatelessWidget {
  final String name;
  final String status;
  final String delay;
  final double value;
  final Color color;

  const TrafficRoadTile({
    super.key,
    required this.name,
    required this.status,
    required this.delay,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.route_rounded, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF171822),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$status traffic',
                      style: const TextStyle(
                        color: Color(0xFF8C8E99),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                delay,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: value,
              valueColor: AlwaysStoppedAnimation(color),
              backgroundColor: const Color(0xFFF0F1F4),
            ),
          ),
        ],
      ),
    );
  }
}

class TrendCard extends StatelessWidget {
  const TrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Predicted congestion trend',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF171822),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Model output for the next 45 minutes',
            style: TextStyle(
              color: Color(0xFF8A8C97),
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: CustomPaint(painter: TrendPainter()),
          ),
        ],
      ),
    );
  }
}

class TrafficCurvePainter extends CustomPainter {
  const TrafficCurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (int i = 1; i < 6; i++) {
      final y = size.height * i / 6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final points = <Offset>[
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.16, size.height * 0.62),
      Offset(size.width * 0.31, size.height * 0.66),
      Offset(size.width * 0.47, size.height * 0.51),
      Offset(size.width * 0.63, size.height * 0.55),
      Offset(size.width * 0.78, size.height * 0.40),
      Offset(size.width, size.height * 0.34),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final a = points[i - 1];
      final b = points[i];
      final mid = (a.dx + b.dx) / 2;
      path.cubicTo(mid, a.dy, mid, b.dy, b.dx, b.dy);
    }

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = const Color(0xFF9D91FF).withOpacity(0.12);

    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFB7ADFF);

    canvas.drawPath(path, glow);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = const Color(0xFFE9EAF0)
      ..strokeWidth = 1;

    for (int i = 1; i <= 4; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final values = [0.88, 0.80, 0.72, 0.64, 0.56, 0.47, 0.40, 0.33];
    final points = <Offset>[];

    for (int i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height * (1 - values[i]) * 0.88 + 8;
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final a = points[i - 1];
      final b = points[i];
      final mid = (a.dx + b.dx) / 2;
      path.cubicTo(mid, a.dy, mid, b.dy, b.dx, b.dy);
    }

    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF6D5DFB);

    canvas.drawPath(path, line);
    final dot = Paint()..color = const Color(0xFF6D5DFB);
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

