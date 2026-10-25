part of 'main.dart';

class TrafficScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigate;
  const TrafficScreen({super.key, this.onNavigate});
  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 132), children: [
        Row(children: [const Expanded(child: Eyebrow('PREDICTIVE INTELLIGENCE')), const TrafficSimulationToggle()]),
        const SizedBox(height: 10),
        Text('Know when\nthe city moves.', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 7),
        const Text('A simulated AI forecast of the next 60 minutes on your route.', style: TextStyle(color: FB.muted, fontSize: 12.5)),
        const SizedBox(height: 20),
        FlowPanel(
          radius: 27,
          padding: const EdgeInsets.all(20),
          color: const Color(0xFF162533),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              FlowTag(label: store.heavyTraffic ? 'HIGH CONGESTION' : 'ROAD FLOWING', color: store.heavyTraffic ? FB.coral : FB.mint, icon: Icons.circle),
              const Spacer(),
              const FlowTag(label: 'MODEL OUTPUT', color: FB.violet, icon: Icons.auto_awesome_rounded),
            ]),
            const SizedBox(height: 22),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('${store.congestion}', style: const TextStyle(color: FB.text, fontSize: 72, height: .9, fontWeight: FontWeight.w900, letterSpacing: -4)),
              const Padding(padding: EdgeInsets.only(bottom: 5), child: Text('%', style: TextStyle(color: FB.muted, fontWeight: FontWeight.w900, fontSize: 28))),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('AI CONFIDENCE', style: TextStyle(fontSize: 10, color: FB.muted, letterSpacing: .9)),
                const SizedBox(height: 4),
                Text('${store.confidence}%', style: const TextStyle(color: FB.mint, fontSize: 24, fontWeight: FontWeight.w900)),
              ]),
            ]),
            const SizedBox(height: 10),
            Text(store.heavyTraffic ? 'Severe slowdown · Kifisias Ave' : 'Light traffic · Kifisias Ave', style: const TextStyle(color: FB.text, fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 20),
            ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(value: store.congestion / 100, minHeight: 8, backgroundColor: FB.elevated, valueColor: AlwaysStoppedAnimation(store.heavyTraffic ? FB.coral : FB.mint))),
            const SizedBox(height: 18),
            Row(children: [
              Expanded(child: _TrafficMetric(icon: Icons.timelapse_rounded, value: store.heavyTraffic ? '~35 min' : 'Cleared', label: 'Predicted clearance')),
              const SizedBox(width: 10),
              Expanded(child: _TrafficMetric(icon: Icons.bolt_rounded, value: store.heavyTraffic ? '22 min' : '0 min', label: 'Potential time savings')),
            ]),
          ]),
        ),
        const SizedBox(height: 26),
        const FlowHeading(title: 'The next 60 minutes', subtitle: 'Predicted congestion index • illustrative model'),
        const SizedBox(height: 12),
        FlowPanel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('TRAFFIC INTENSITY', style: TextStyle(color: FB.muted, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: .9)),
            const Spacer(),
            Icon(Icons.circle, color: store.heavyTraffic ? FB.coral : FB.mint, size: 9),
            const SizedBox(width: 5),
            Text(store.heavyTraffic ? 'Expected to fall' : 'Already low', style: const TextStyle(color: FB.text, fontSize: 10)),
          ]),
          const SizedBox(height: 15),
          SizedBox(height: 180, child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 360),
            child: CustomPaint(
              key: ValueKey(store.heavyTraffic),
              size: const Size(double.infinity, 180),
              painter: ForecastLinePainter(heavy: store.heavyTraffic),
            ),
          )),
          const SizedBox(height: 11),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('NOW', style: TextStyle(color: FB.muted, fontSize: 10)),
            Text('+15m', style: TextStyle(color: FB.muted, fontSize: 10)),
            Text('+30m', style: TextStyle(color: FB.muted, fontSize: 10)),
            Text('+45m', style: TextStyle(color: FB.muted, fontSize: 10)),
            Text('+60m', style: TextStyle(color: FB.muted, fontSize: 10)),
          ]),
        ])),
        const SizedBox(height: 26),
        FlowHeading(title: 'Stop or stay in traffic?', subtitle: 'The decision FlowBite helps you make'),
        const SizedBox(height: 12),
        _TimeTradeoff(store: store),
        const SizedBox(height: 20),
        FlowPanel(color: const Color(0xFF182F32), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.psychology_rounded, color: FB.mint, size: 23),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('How the prediction works', style: TextStyle(color: FB.text, fontWeight: FontWeight.w900, fontSize: 14)),
            const SizedBox(height: 6),
            Text(store.heavyTraffic
                ? 'A mock forecasting engine anticipates congestion dropping from 88% toward 18% over an hour. The recommender uses a 35-minute high-delay window to select sensible stops.'
                : 'The simulator now reports light congestion. Since stopping would add time, FlowBite pauses flash discounts and recommends continuing your trip.',
              style: const TextStyle(color: FB.muted, fontSize: 11.5, height: 1.5)),
            const SizedBox(height: 7),
            const Text('Illustrative values, not live sensor data.', style: TextStyle(color: FB.mint, fontSize: 10)),
          ])),
        ])),
        if (store.heavyTraffic && onNavigate != null) ...[
          const SizedBox(height: 17),
          SizedBox(width: double.infinity, child: FlowButton(label: 'See your recommended stops', icon: Icons.arrow_forward_rounded, onPressed: () => onNavigate!(1))),
        ],
      ]),
    );
  }
}

class _TrafficMetric extends StatelessWidget {
  final IconData icon;
  final String value, label;
  const _TrafficMetric({required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: FB.bg.withOpacity(.57), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: FB.amber, size: 20),
      const SizedBox(height: 9),
      Text(value, style: const TextStyle(color: FB.text, fontSize: 20, fontWeight: FontWeight.w900)),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(color: FB.muted, fontSize: 10.5)),
    ]),
  );
}

class _TimeTradeoff extends StatelessWidget {
  final FlowBiteStore store;
  const _TimeTradeoff({required this.store});
  @override
  Widget build(BuildContext context) => FlowPanel(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.route_rounded, color: FB.coral, size: 20),
        const SizedBox(width: 9),
        const Expanded(child: Text('Keep driving now', style: TextStyle(color: FB.text, fontWeight: FontWeight.w800, fontSize: 13))),
        Text('${store.driveNow} min', style: const TextStyle(color: FB.coral, fontWeight: FontWeight.w900, fontSize: 18)),
      ]),
      const SizedBox(height: 8),
      LinearProgressIndicator(value: store.driveNow / 70, minHeight: 8, borderRadius: BorderRadius.circular(20), color: FB.coral, backgroundColor: FB.bg),
      const SizedBox(height: 21),
      Row(children: [
        const Icon(Icons.coffee_rounded, color: FB.mint, size: 20),
        const SizedBox(width: 9),
        const Expanded(child: Text('Pitstop + continue', style: TextStyle(color: FB.text, fontWeight: FontWeight.w800, fontSize: 13))),
        Text('${store.pauseAndGo} min', style: const TextStyle(color: FB.mint, fontWeight: FontWeight.w900, fontSize: 18)),
      ]),
      const SizedBox(height: 8),
      LinearProgressIndicator(value: store.pauseAndGo / 70, minHeight: 8, borderRadius: BorderRadius.circular(20), color: FB.mint, backgroundColor: FB.bg),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: store.heavyTraffic ? FB.mint.withOpacity(.12) : FB.amber.withOpacity(.11), borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          Icon(store.heavyTraffic ? Icons.savings_rounded : Icons.directions_car_rounded, color: store.heavyTraffic ? FB.mint : FB.amber),
          const SizedBox(width: 10),
          Expanded(child: Text(store.heavyTraffic ? 'SAVE UP TO 22 MIN BY PAUSING' : 'STAY ON ROUTE — NO TIME BENEFIT', style: TextStyle(color: store.heavyTraffic ? FB.mint : FB.amber, fontWeight: FontWeight.w900, fontSize: 11))),
        ]),
      ),
      const SizedBox(height: 10),
      const Text('Illustrative end-to-end trip estimates; break time is included.', style: TextStyle(color: FB.muted, fontSize: 10)),
    ]),
  );
}

class ForecastLinePainter extends CustomPainter {
  final bool heavy;
  const ForecastLinePainter({required this.heavy});

  @override
  void paint(Canvas canvas, Size size) {
    final color = heavy ? FB.coral : FB.mint;
    final values = heavy ? <double>[.88, .85, .78, .68, .54, .39, .27, .2, .18] : <double>[.18, .15, .14, .12, .11, .09, .09, .08, .07];
    final w = size.width, h = size.height;
    final gridPaint = Paint()..color = FB.line..strokeWidth = 1;
    for (var n = 0; n <= 4; n++) {
      final y = h * n / 4;
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }
    Offset point(int i) => Offset(i * w / (values.length - 1), 8 + (h - 16) * (1 - values[i]));
    final route = Path()..moveTo(point(0).dx, point(0).dy);
    for (var i = 1; i < values.length; i++) {
      route.lineTo(point(i).dx, point(i).dy);
    }
    final area = Path.from(route)..lineTo(w, h)..lineTo(0, h)..close();
    canvas.drawPath(area, Paint()..shader = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color.withOpacity(.30), color.withOpacity(.01)]).createShader(Rect.fromLTWH(0, 0, w, h)));
    canvas.drawPath(route, Paint()..style = PaintingStyle.stroke..strokeWidth = 3.5..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round..color = color);
    for (final i in [0, 4, 8]) {
      final p = point(i);
      canvas.drawCircle(p, 6.5, Paint()..color = FB.card);
      canvas.drawCircle(p, 4.5, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant ForecastLinePainter oldDelegate) => oldDelegate.heavy != heavy;
}
