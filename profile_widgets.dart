part of 'main.dart';

// Reusable design-system widgets and the Saved / Preferences destination.
class Eyebrow extends StatelessWidget {
  final String text;
  final Color color;
  const Eyebrow(this.text, {super.key, this.color = FB.mint});
  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(),
      style: TextStyle(color: color, letterSpacing: 1.8, fontWeight: FontWeight.w900, fontSize: 10));
}

class FlowHeading extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  const FlowHeading({super.key, required this.title, this.subtitle, this.trailing});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: const TextStyle(color: FB.muted, fontSize: 12, height: 1.3))]
      ])),
      if (trailing != null) trailing!,
    ],
  );
}

class FlowPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final double radius;
  final Border? border;
  const FlowPanel({super.key, required this.child, this.padding = const EdgeInsets.all(18), this.color = FB.card, this.radius = 24, this.border});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border ?? Border.all(color: FB.line.withOpacity(.75)),
    ),
    child: child,
  );
}

class FlowTag extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final bool solid;
  const FlowTag({super.key, required this.label, this.icon, this.color = FB.mint, this.solid = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(color: solid ? color : color.withOpacity(.12), borderRadius: BorderRadius.circular(9), border: solid ? null : Border.all(color: color.withOpacity(.17))),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      if (icon != null) ...[Icon(icon, size: 12, color: solid ? FB.bg : color), const SizedBox(width: 5)],
      Text(label, style: TextStyle(color: solid ? FB.bg : color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: .2)),
    ]),
  );
}

class FlowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool secondary;
  const FlowButton({super.key, required this.label, required this.icon, required this.onPressed, this.secondary = false});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 51,
    child: FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
      style: FilledButton.styleFrom(
        backgroundColor: secondary ? FB.elevated : FB.mint,
        foregroundColor: secondary ? FB.text : FB.bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}

class TrafficSimulationToggle extends StatelessWidget {
  const TrafficSimulationToggle({super.key});
  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    return Tooltip(
      message: 'Switch traffic conditions (demo)',
      child: InkWell(
        onTap: () {
          store.toggleTraffic();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(store.heavyTraffic ? 'Demo: heavy congestion activated' : 'Demo: traffic cleared — flash deals paused'),
          ));
        },
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: store.heavyTraffic ? FB.coral.withOpacity(.13) : FB.mint.withOpacity(.14),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: (store.heavyTraffic ? FB.coral : FB.mint).withOpacity(.4)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.sync_rounded, size: 16, color: store.heavyTraffic ? FB.coral : FB.mint),
            const SizedBox(width: 6),
            Text(store.heavyTraffic ? 'SIM: JAM' : 'SIM: CLEAR', style: TextStyle(fontSize: 10, color: store.heavyTraffic ? FB.coral : FB.mint, fontWeight: FontWeight.w900)),
          ]),
        ),
      ),
    );
  }
}

class VenueSymbol extends StatelessWidget {
  final Pitstop venue;
  final double size;
  const VenueSymbol({super.key, required this.venue, this.size = 54});
  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [venue.accent.withOpacity(.32), venue.accent.withOpacity(.07)]),
      borderRadius: BorderRadius.circular(size * .3),
      border: Border.all(color: venue.accent.withOpacity(.2)),
    ),
    child: Icon(venue.icon, color: venue.accent, size: size * .48),
  );
}

class SavedProfileScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const SavedProfileScreen({super.key, required this.onNavigate});
  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    final claimed = mockVenues.where((v) => store.claimedIds.contains(v.id)).toList();
    final saved = mockVenues.where((v) => store.favorites.contains(v.id)).toList();
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 25, 20, 130), children: [
        const Eyebrow('YOUR FLOWBITE'),
        const SizedBox(height: 9),
        Text('Your pitstop space', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 7),
        const Text('Vouchers, favorites and the tastes that power your recommendations.', style: TextStyle(color: FB.muted, fontSize: 13)),
        const SizedBox(height: 24),
        FlowPanel(
          color: const Color(0xFF172C33),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: FB.mint.withOpacity(.14), borderRadius: BorderRadius.circular(17)), child: const Icon(Icons.confirmation_number_rounded, color: FB.mint, size: 27)),
            const SizedBox(width: 15),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${claimed.length} active ${claimed.length == 1 ? 'pass' : 'passes'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: FB.text)),
              const SizedBox(height: 3),
              const Text('Demo QR vouchers, saved on this device session', style: TextStyle(fontSize: 11, color: FB.muted)),
            ])),
            const Icon(Icons.qr_code_2_rounded, color: FB.mint, size: 30),
          ]),
        ),
        const SizedBox(height: 27),
        FlowHeading(title: 'My flash passes', subtitle: store.heavyTraffic ? 'Claimed during congestion' : 'Already claimed passes are still visible', trailing: const Icon(Icons.bolt_rounded, color: FB.amber)),
        const SizedBox(height: 13),
        if (claimed.isEmpty)
          FlowPanel(child: Column(children: [
            const Icon(Icons.local_activity_outlined, color: FB.amber, size: 34),
            const SizedBox(height: 9),
            const Text('No passes yet', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: FB.text)),
            const SizedBox(height: 6),
            const Text('Browse live offers and claim a pitstop flash pass.', textAlign: TextAlign.center, style: TextStyle(color: FB.muted, fontSize: 12)),
            const SizedBox(height: 14),
            FlowButton(label: 'Explore offers', icon: Icons.arrow_forward_rounded, onPressed: () => onNavigate(1)),
          ]))
        else ...claimed.map((venue) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => showPassSheet(context, venue),
            child: FlowPanel(child: Row(children: [
              VenueSymbol(venue: venue, size: 50),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(venue.name, style: const TextStyle(fontWeight: FontWeight.w900, color: FB.text)),
                const SizedBox(height: 4),
                const Text('Tap to view your QR pass', style: TextStyle(color: FB.muted, fontSize: 11)),
              ])),
              const Icon(Icons.qr_code_rounded, color: FB.mint),
            ])),
          ),
        )),
        const SizedBox(height: 27),
        const FlowHeading(title: 'Your taste profile', subtitle: 'Changing these updates the recommendation ranking'),
        const SizedBox(height: 13),
        PreferenceTile(icon: Icons.coffee_rounded, title: 'Coffee stops', subtitle: 'Espresso bars and quiet cafés', value: store.coffeePreference, onChanged: store.setCoffee, accent: FB.amber),
        PreferenceTile(icon: Icons.laptop_rounded, title: 'Quiet workspaces', subtitle: 'Wi-Fi and desk-friendly venues', value: store.workspacePreference, onChanged: store.setWorkspace, accent: FB.violet),
        PreferenceTile(icon: Icons.lunch_dining_rounded, title: 'Food & bites', subtitle: 'Fast meals and desserts', value: store.foodPreference, onChanged: store.setFood, accent: FB.coral),
        PreferenceTile(icon: Icons.savings_rounded, title: 'Budget-friendly only', subtitle: 'Places priced at €7.50 or less', value: store.budgetPreference, onChanged: store.setBudget, accent: FB.mint),
        const SizedBox(height: 22),
        FlowHeading(title: 'Favorite places', subtitle: '${saved.length} saved for later'),
        const SizedBox(height: 12),
        if (saved.isEmpty) const FlowPanel(child: Text('Tap the heart on an offer to save it here.', style: TextStyle(color: FB.muted)))
        else ...saved.map((v) => Padding(padding: const EdgeInsets.only(bottom: 9), child: GestureDetector(
          onTap: () => showOfferSheet(context, v),
          child: FlowPanel(padding: const EdgeInsets.all(12), child: Row(children: [
            VenueSymbol(venue: v, size: 42), const SizedBox(width: 10),
            Expanded(child: Text(v.name, style: const TextStyle(color: FB.text, fontWeight: FontWeight.w800))),
            IconButton(tooltip: 'Remove favorite', onPressed: () => store.toggleFavorite(v.id), icon: const Icon(Icons.favorite_rounded, color: FB.coral)),
          ])),
        ))),
        const SizedBox(height: 18),
        const Center(child: Text('FLOWBITE • INTERACTIVE COURSEWORK DEMO', style: TextStyle(fontSize: 9, color: FB.muted, letterSpacing: 1.1))),
      ]),
    );
  }
}

class PreferenceTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color accent;
  const PreferenceTile({super.key, required this.icon, required this.title, required this.subtitle, required this.value, required this.onChanged, required this.accent});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: FlowPanel(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Row(children: [
      Container(width: 41, height: 41, decoration: BoxDecoration(color: accent.withOpacity(.12), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: accent, size: 21)),
      const SizedBox(width: 11),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: FB.text, fontSize: 13, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: FB.muted, fontSize: 10.5)),
      ])),
      Switch(value: value, onChanged: onChanged, activeColor: FB.bg, activeTrackColor: FB.mint, inactiveThumbColor: FB.muted, inactiveTrackColor: FB.elevated),
    ])),
  );
}

void showPassSheet(BuildContext context, Pitstop venue) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: FB.card,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
    builder: (sheetContext) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 26),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const FlowTag(label: 'DEMO VOUCHER • CLAIMED', color: FB.mint, icon: Icons.check_circle_rounded),
          const SizedBox(height: 16),
          Text(venue.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: FB.text)),
          const SizedBox(height: 6),
          Text('${venue.discount}% off • ${venue.offerLabel}', style: const TextStyle(color: FB.amber, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          Container(
            width: 226, height: 226, padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: CustomPaint(painter: FakeQrPainter(venue.id)),
          ),
          const SizedBox(height: 13),
          Text('FB-${venue.id.toUpperCase()}-DEMO', style: const TextStyle(letterSpacing: 2, color: FB.text, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Visual QR mockup only — not scannable or redeemable.', textAlign: TextAlign.center, style: TextStyle(color: FB.muted, fontSize: 11)),
          const SizedBox(height: 23),
          SizedBox(width: double.infinity, child: FlowButton(label: 'Done', icon: Icons.check_rounded, onPressed: () => Navigator.of(sheetContext).pop())),
        ]),
      ),
    ),
  );
}

class FakeQrPainter extends CustomPainter {
  final String seed;
  const FakeQrPainter(this.seed);
  @override
  void paint(Canvas canvas, Size size) {
    const n = 25;
    final unit = size.width / n;
    final ink = Paint()..color = const Color(0xFF0A121A);
    final rand = math.Random(seed.codeUnits.fold<int>(101, (sum, v) => (sum * 31 + v) & 0x7fffffff));
    bool finder(int x, int y, int left, int top) {
      final dx = x - left, dy = y - top;
      if (dx < 0 || dy < 0 || dx >= 7 || dy >= 7) return false;
      final border = dx == 0 || dy == 0 || dx == 6 || dy == 6;
      final center = dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4;
      return border || center;
    }
    bool reserved(int x, int y) => (x < 8 && y < 8) || (x >= n - 8 && y < 8) || (x < 8 && y >= n - 8);
    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        final active = reserved(x, y)
            ? finder(x, y, 0, 0) || finder(x, y, n - 7, 0) || finder(x, y, 0, n - 7)
            : rand.nextBool();
        if (active) canvas.drawRect(Rect.fromLTWH(x * unit, y * unit, unit + .15, unit + .15), ink);
      }
    }
  }
  @override
  bool shouldRepaint(covariant FakeQrPainter oldDelegate) => oldDelegate.seed != seed;
}
