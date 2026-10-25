part of 'main.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    final top = store.rankedVenues.take(4).toList();
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 23, 20, 132), children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: FB.mint, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.route_rounded, color: FB.bg, size: 26)),
          const SizedBox(width: 11),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('FLOWBITE', style: TextStyle(color: FB.text, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
            Text('Make traffic time yours.', style: TextStyle(color: FB.muted, fontSize: 10.5)),
          ])),
          const TrafficSimulationToggle(),
        ]),
        const SizedBox(height: 28),
        const Eyebrow('LIVE COMMUTE · ATHENS'),
        const SizedBox(height: 6),
        Text(store.heavyTraffic ? 'The road can wait.\nYour day can’t.' : 'Good news.\nYou’re moving.',
            style: const TextStyle(color: FB.text, fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -1.35, height: 1.11)),
        const SizedBox(height: 18),
        _CongestionHero(store: store, onBrowse: () => onNavigate(1)),
        const SizedBox(height: 26),
        FlowHeading(title: 'Live radar', subtitle: 'Kifisias Avenue · northbound', trailing: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const FullRadarScreen())),
          child: const FlowTag(label: 'EXPAND', icon: Icons.open_in_full_rounded),
        )),
        const SizedBox(height: 12),
        const FlowRadarMap(height: 244),
        const SizedBox(height: 26),
        FlowHeading(
          title: store.heavyTraffic ? 'Your perfect pitstops' : 'Places along your route',
          subtitle: store.heavyTraffic ? 'Ranked for the next 35 minutes' : 'Flash discounts return during traffic spikes',
          trailing: TextButton(onPressed: () => onNavigate(1), child: const Text('See all', style: TextStyle(color: FB.mint, fontWeight: FontWeight.w800))),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 208,
          child: PageView.builder(
            padEnds: false,
            controller: PageController(viewportFraction: .88),
            itemCount: top.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: RadarPitstopCard(ranked: top[i], active: store.heavyTraffic, onTap: () => showOfferSheet(context, top[i].venue)),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FlowPanel(
          color: const Color(0xFF142F32),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: FB.mint.withOpacity(.13), borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.psychology_alt_rounded, color: FB.mint, size: 24)),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Two smart engines. One better stop.', style: TextStyle(fontWeight: FontWeight.w900, color: FB.text, fontSize: 14)),
              SizedBox(height: 5),
              Text('Traffic AI estimates when the jam ends. FlowBite then scores venues by walking time, visit duration, discount and your tastes.', style: TextStyle(fontSize: 11.5, color: FB.muted, height: 1.5)),
              SizedBox(height: 7),
              Text('Simulated demo • use only when stopped or as a passenger.', style: TextStyle(fontSize: 10, color: FB.mint)),
            ])),
          ]),
        ),
      ]),
    );
  }
}

class _CongestionHero extends StatelessWidget {
  final FlowBiteStore store;
  final VoidCallback onBrowse;
  const _CongestionHero({required this.store, required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    final jam = store.heavyTraffic;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 420),
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: jam ? [const Color(0xFF3C283B), const Color(0xFF22273B), const Color(0xFF1A303B)] : [const Color(0xFF173B3A), const Color(0xFF132D35), const Color(0xFF17283C)],
        ),
        border: Border.all(color: (jam ? FB.coral : FB.mint).withOpacity(.26)),
        boxShadow: [BoxShadow(color: (jam ? FB.coral : FB.mint).withOpacity(.08), blurRadius: 36, offset: const Offset(0, 18))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          FlowTag(label: jam ? 'TRAFFIC SPIKE DETECTED' : 'TRAFFIC CLEARED', icon: jam ? Icons.warning_amber_rounded : Icons.check_circle_rounded, color: jam ? FB.coral : FB.mint),
          const Spacer(),
          const Icon(Icons.auto_awesome_rounded, color: FB.amber, size: 18),
          const SizedBox(width: 5),
          const Text('AI LIVE', style: TextStyle(color: FB.amber, fontSize: 10, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 20),
        const Text('KIFISIAS AVENUE', style: TextStyle(color: Color(0xFFC0CAD1), fontSize: 11, letterSpacing: 1.4, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(jam ? 'Gridlock clears in\n~35 minutes' : 'Road is clear.\nKeep going!',
            key: ValueKey(jam), style: const TextStyle(color: FB.text, fontSize: 29, letterSpacing: -.8, height: 1.12, fontWeight: FontWeight.w900)),
        ),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: _HeroStat(value: '${store.congestion}%', label: 'Congestion', color: jam ? FB.coral : FB.mint)),
          const SizedBox(width: 9),
          Expanded(child: _HeroStat(value: '${store.confidence}%', label: 'Model confidence', color: FB.amber)),
          const SizedBox(width: 9),
          Expanded(child: _HeroStat(value: '${store.estimatedSavings}m', label: 'Time saved', color: FB.mint)),
        ]),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FlowButton(label: jam ? 'Find my smart pitstop' : 'Browse places nearby', icon: Icons.arrow_forward_rounded, onPressed: onBrowse)),
      ]),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _HeroStat({required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
    decoration: BoxDecoration(color: Colors.white.withOpacity(.055), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(.055))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value, style: TextStyle(color: color, fontSize: 23, letterSpacing: -.7, fontWeight: FontWeight.w900)),
      const SizedBox(height: 3),
      Text(label, maxLines: 2, style: const TextStyle(fontSize: 9.5, color: Color(0xFFCBD7DD), height: 1.2)),
    ]),
  );
}

class RadarPitstopCard extends StatelessWidget {
  final RankedPitstop ranked;
  final bool active;
  final VoidCallback onTap;
  const RadarPitstopCard({super.key, required this.ranked, required this.active, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final venue = ranked.venue;
    return Material(
      color: FB.card,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: FB.line)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              VenueSymbol(venue: venue, size: 48),
              const Spacer(),
              FlowTag(label: active ? '-${venue.discount}%' : 'NO FLASH', color: active ? FB.amber : FB.muted, icon: active ? Icons.bolt_rounded : null),
            ]),
            const SizedBox(height: 13),
            Text(venue.name, style: const TextStyle(color: FB.text, fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            Text(venue.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: FB.muted, fontSize: 11)),
            const Spacer(),
            Row(children: [
              const Icon(Icons.directions_walk_rounded, color: FB.muted, size: 15),
              const SizedBox(width: 3),
              Text('${venue.walkMinutes} min', style: const TextStyle(color: FB.muted, fontSize: 11)),
              const Spacer(),
              const Icon(Icons.auto_awesome_rounded, color: FB.mint, size: 14),
              const SizedBox(width: 5),
              Text('${ranked.match}% match', style: const TextStyle(color: FB.mint, fontWeight: FontWeight.w900, fontSize: 11)),
            ]),
          ]),
        ),
      ),
    );
  }
}
