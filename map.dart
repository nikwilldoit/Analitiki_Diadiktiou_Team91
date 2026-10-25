part of 'main.dart';

// Custom-painted, stylized map illustration: no map tiles, GPS or API key.
class FlowRadarMap extends StatelessWidget {
  final double height;
  final String? focusedVenueId;
  const FlowRadarMap({super.key, required this.height, this.focusedVenueId});

  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFF102431), border: Border.all(color: FB.line), borderRadius: BorderRadius.circular(25)),
          child: LayoutBuilder(builder: (context, bounds) {
            final w = bounds.maxWidth, h = bounds.maxHeight;
            return Stack(children: [
              Positioned.fill(child: CustomPaint(painter: FlowMapPainter(heavy: store.heavyTraffic))),
              Positioned(top: 12, left: 12, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(color: const Color(0xE40B1B26), borderRadius: BorderRadius.circular(11), border: Border.all(color: FB.line)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.radar_rounded, color: FB.mint, size: 14), SizedBox(width: 5),
                  Text('LIVE ROAD LAYER', style: TextStyle(color: FB.text, fontSize: 9, letterSpacing: .8, fontWeight: FontWeight.w900)),
                ]),
              )),
              Positioned(right: 12, top: 13, child: FlowTag(label: store.heavyTraffic ? 'GRIDLOCK' : 'CLEAR', color: store.heavyTraffic ? FB.coral : FB.mint)),
              for (final venue in mockVenues.where((venue) => focusedVenueId == null || venue.id == focusedVenueId || h > 340))
                Positioned(
                  left: (w - 52) * venue.mapX,
                  top: 25 + (h - 93) * venue.mapY,
                  child: _MapDealPin(venue: venue, active: store.heavyTraffic, highlighted: venue.id == focusedVenueId, onTap: () => showOfferSheet(context, venue)),
                ),
              Positioned(
                left: (w - 36) * .49,
                top: (h - 36) * .45,
                child: Container(width: 36, height: 36, decoration: BoxDecoration(shape: BoxShape.circle, color: FB.mint.withOpacity(.18), border: Border.all(color: FB.mint.withOpacity(.4), width: 2)),
                  child: Center(child: Container(width: 19, height: 19, decoration: const BoxDecoration(shape: BoxShape.circle, color: FB.mint), child: const Icon(Icons.navigation_rounded, color: FB.bg, size: 12))),
                ),
              ),
              Positioned(bottom: 12, left: 12, right: 12, child: IgnorePointer(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                decoration: BoxDecoration(color: const Color(0xEE091A23), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(Icons.place_rounded, color: FB.amber, size: 14),
                  const SizedBox(width: 5),
                  const Expanded(child: Text('Kifisias Ave · Athens', style: TextStyle(color: FB.text, fontSize: 10, fontWeight: FontWeight.w700))),
                  Text(store.heavyTraffic ? '● Delay' : '● Flowing', style: TextStyle(color: store.heavyTraffic ? FB.coral : FB.mint, fontSize: 10, fontWeight: FontWeight.w800)),
                ]),
              ))),
            ]);
          }),
        ),
      ),
    );
  }
}

class _MapDealPin extends StatelessWidget {
  final Pitstop venue;
  final bool active;
  final bool highlighted;
  final VoidCallback onTap;
  const _MapDealPin({required this.venue, required this.active, required this.highlighted, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 480),
      tween: Tween<double>(begin: 0.92, end: 1.0),
      builder: (context, scale, child) => Transform.scale(scale: highlighted ? scale * 1.15 : scale, child: child),
      child: Container(
        width: 49,
        height: 49,
        decoration: BoxDecoration(
          color: const Color(0xFF172A37),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: highlighted ? FB.mint : venue.accent, width: highlighted ? 2.5 : 1.5),
          boxShadow: [BoxShadow(color: venue.accent.withOpacity(.24), blurRadius: 13, spreadRadius: 1)],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(venue.icon, color: venue.accent, size: 21),
          Text(active ? '-${venue.discount}%' : 'NEAR', style: TextStyle(color: active ? FB.text : FB.muted, fontSize: 8.5, fontWeight: FontWeight.w900)),
        ]),
      ),
    ),
  );
}

class FullRadarScreen extends StatelessWidget {
  final String? focusedVenueId;
  const FullRadarScreen({super.key, this.focusedVenueId});
  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    final venue = focusedVenueId == null ? null : store.getVenue(focusedVenueId!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FB.bg,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text('Live traffic radar', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
        actions: const [Padding(padding: EdgeInsets.only(right: 16), child: Center(child: TrafficSimulationToggle()))],
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 9, 15, 17),
        child: Column(children: [
          const Text('Illustrative Athens road network • tap a venue marker', style: TextStyle(color: FB.muted, fontSize: 12)),
          const SizedBox(height: 13),
          Expanded(child: LayoutBuilder(builder: (context, box) => FlowRadarMap(height: box.maxHeight, focusedVenueId: focusedVenueId))),
          if (venue != null) ...[
            const SizedBox(height: 13),
            FlowPanel(child: Row(children: [
              VenueSymbol(venue: venue, size: 45),
              const SizedBox(width: 11),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(venue.name, style: const TextStyle(color: FB.text, fontWeight: FontWeight.w900)),
                Text('${venue.walkMinutes}-min walk · ${venue.category}', style: const TextStyle(color: FB.muted, fontSize: 11)),
              ])),
              TextButton(onPressed: () => showOfferSheet(context, venue), child: const Text('Offer', style: TextStyle(color: FB.mint, fontWeight: FontWeight.w900))),
            ])),
          ],
        ]),
      )),
    );
  }
}

class FlowMapPainter extends CustomPainter {
  final bool heavy;
  const FlowMapPainter({required this.heavy});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    // Blocks / neighborhoods.
    final block = Paint()..color = const Color(0xFF172F3A);
    for (var row = 0; row < 6; row++) {
      for (var col = 0; col < 7; col++) {
        final x = (col + .15) * w / 7, y = (row + .22) * h / 6;
        final rect = RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w / 10.3, h / 12.2), const Radius.circular(5));
        canvas.drawRRect(rect, block);
      }
    }

    Path road(List<Offset> pts) {
      final path = Path()..moveTo(pts.first.dx * w, pts.first.dy * h);
      for (var i = 1; i < pts.length; i++) {
        path.lineTo(pts[i].dx * w, pts[i].dy * h);
      }
      return path;
    }

    final roads = <Path>[
      road([const Offset(-.1, .27), const Offset(.36, .31), const Offset(.76, .09), const Offset(1.1, .17)]),
      road([const Offset(-.1, .72), const Offset(.31, .67), const Offset(.72, .8), const Offset(1.1, .59)]),
      road([const Offset(.14, -.1), const Offset(.25, .43), const Offset(.12, 1.1)]),
      road([const Offset(.84, -.1), const Offset(.71, .39), const Offset(.85, 1.1)]),
      road([const Offset(.45, -.1), const Offset(.4, .40), const Offset(.56, 1.08)]),
      road([const Offset(-.1, .47), const Offset(.46, .49), const Offset(1.1, .38)]),
    ];

    for (final path in roads) {
      canvas.drawPath(path, Paint()..color = const Color(0xFF284352)..strokeWidth = 18..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
      canvas.drawPath(path, Paint()..color = const Color(0xFF3E5A66)..strokeWidth = 11..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
    }

    final mainRoad = road([const Offset(.51, -.07), const Offset(.55, .18), const Offset(.51, .41), const Offset(.62, .67), const Offset(.60, 1.08)]);
    canvas.drawPath(mainRoad, Paint()..color = const Color(0xFF142330)..strokeWidth = 31..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
    canvas.drawPath(mainRoad, Paint()..color = (heavy ? const Color(0xFFFF6577) : FB.mint)..strokeWidth = 15..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);
    canvas.drawPath(road([const Offset(.52, .24), const Offset(.31, .36), const Offset(.08, .4)]), Paint()..color = (heavy ? FB.amber : FB.mint)..strokeWidth = 9..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
    canvas.drawPath(road([const Offset(.61, .57), const Offset(.86, .52), const Offset(1.03, .59)]), Paint()..color = (heavy ? FB.coral : FB.mint)..strokeWidth = 9..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);

    // Junctions, lane markings, subtle route highlight.
    final dashPaint = Paint()..color = Colors.white.withOpacity(.35)..strokeWidth = 1.6;
    for (var i = 0; i < 10; i++) {
      final y = (i + .2) * h / 10;
      canvas.drawLine(Offset(.55 * w, y), Offset(.55 * w + 1.7, y + 6), dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant FlowMapPainter oldDelegate) => oldDelegate.heavy != heavy;
}
