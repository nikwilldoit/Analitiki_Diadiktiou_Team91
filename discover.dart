part of 'main.dart';

class DiscoverScreen extends StatefulWidget {
  final ValueChanged<int> onNavigate;
  const DiscoverScreen({super.key, required this.onNavigate});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String search = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  static const categories = ['All', 'Coffee', 'Workspace', 'Food', 'Dessert'];

  @override
  Widget build(BuildContext context) {
    final store = FlowBiteScope.of(context);
    final results = store.rankedVenues.where((ranked) {
      final q = search.trim().toLowerCase();
      return ranked.venue.name.toLowerCase().contains(q) ||
          ranked.venue.category.toLowerCase().contains(q) ||
          ranked.venue.subtitle.toLowerCase().contains(q);
    }).toList();

    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 134), children: [
        Row(children: [
          const Expanded(child: Eyebrow('YOUR PERSONAL RECOMMENDER')),
          const TrafficSimulationToggle(),
        ]),
        const SizedBox(height: 10),
        Text('The right stop.\nRight on time.', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 7),
        const Text('Discover offers matched to your predicted traffic delay.', style: TextStyle(color: FB.muted, fontSize: 12.5)),
        const SizedBox(height: 20),
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: store.heavyTraffic ? const Color(0xFF2B2B32) : const Color(0xFF15332D),
            border: Border.all(color: (store.heavyTraffic ? FB.amber : FB.mint).withOpacity(.25)),
          ),
          child: Row(children: [
            Icon(store.heavyTraffic ? Icons.bolt_rounded : Icons.check_circle_rounded, color: store.heavyTraffic ? FB.amber : FB.mint, size: 25),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(store.heavyTraffic ? 'FLASH DEALS ARE LIVE' : 'TRAFFIC CLEARED', style: TextStyle(color: store.heavyTraffic ? FB.amber : FB.mint, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
              const SizedBox(height: 3),
              Text(store.heavyTraffic ? 'Offers calibrated for a 35-minute jam' : 'Flash passes are temporarily paused', style: const TextStyle(color: FB.text, fontSize: 12)),
            ])),
            FlowTag(label: store.heavyTraffic ? 'LIVE' : 'PAUSED', color: store.heavyTraffic ? FB.coral : FB.muted),
          ]),
        ),
        const SizedBox(height: 21),
        TextField(
          controller: searchController,
          onChanged: (value) => setState(() => search = value),
          cursorColor: FB.mint,
          style: const TextStyle(color: FB.text),
          decoration: InputDecoration(
            hintText: 'Try coffee, workspace or a venue…',
            hintStyle: const TextStyle(color: FB.muted, fontSize: 12),
            prefixIcon: const Icon(Icons.search_rounded, color: FB.muted),
            filled: true,
            fillColor: FB.card,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: const BorderSide(color: FB.line)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: const BorderSide(color: FB.line)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: const BorderSide(color: FB.mint)),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 41,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final selected = store.category == categories[i];
              return ChoiceChip(
                label: Text(categories[i]),
                selected: selected,
                showCheckmark: false,
                onSelected: (_) => store.setCategory(categories[i]),
                selectedColor: FB.mint,
                backgroundColor: FB.card,
                side: BorderSide(color: selected ? FB.mint : FB.line),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                labelStyle: TextStyle(color: selected ? FB.bg : FB.text, fontWeight: FontWeight.w800, fontSize: 11),
              );
            },
          ),
        ),
        const SizedBox(height: 25),
        FlowHeading(title: 'Recommended for you', subtitle: '${results.length} places • ranked by FlowBite score', trailing: const FlowTag(label: 'AI MATCH', icon: Icons.auto_awesome_rounded)),
        const SizedBox(height: 13),
        if (results.isEmpty)
          FlowPanel(child: Column(children: [
            const Icon(Icons.search_off_rounded, color: FB.muted, size: 30),
            const SizedBox(height: 10),
            const Text('No pitstops match these filters', style: TextStyle(color: FB.text, fontWeight: FontWeight.w900)),
            const SizedBox(height: 5),
            const Text('Try another category or disable the budget filter.', textAlign: TextAlign.center, style: TextStyle(color: FB.muted, fontSize: 12)),
            const SizedBox(height: 10),
            TextButton(onPressed: () { store.setCategory('All'); searchController.clear(); setState(() => search = ''); }, child: const Text('Clear category', style: TextStyle(color: FB.mint))),
          ]))
        else ...results.map((ranked) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SmartOfferTile(ranked: ranked, store: store, onTap: () => showOfferSheet(context, ranked.venue)),
        )),
        const SizedBox(height: 10),
        FlowPanel(color: const Color(0xFF172A35), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.tune_rounded, color: FB.violet, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Your preferences make the difference', style: TextStyle(color: FB.text, fontWeight: FontWeight.w900, fontSize: 13)),
            const SizedBox(height: 5),
            const Text('Match scores react to category preference, walking time, visit duration, prices and the live traffic scenario.', style: TextStyle(color: FB.muted, fontSize: 11.5, height: 1.45)),
            const SizedBox(height: 7),
            GestureDetector(onTap: () => widget.onNavigate(3), child: const Text('Edit your tastes  →', style: TextStyle(color: FB.mint, fontSize: 12, fontWeight: FontWeight.w900))),
          ])),
        ])),
      ]),
    );
  }
}

class SmartOfferTile extends StatelessWidget {
  final RankedPitstop ranked;
  final FlowBiteStore store;
  final VoidCallback onTap;
  const SmartOfferTile({super.key, required this.ranked, required this.store, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final venue = ranked.venue;
    return Material(
      color: FB.card,
      borderRadius: BorderRadius.circular(23),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), border: Border.all(color: FB.line)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              VenueSymbol(venue: venue, size: 59),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(venue.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: FB.text)),
                const SizedBox(height: 4),
                Text(venue.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: FB.muted, fontSize: 11)),
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.star_rounded, color: FB.amber, size: 14),
                  const SizedBox(width: 2),
                  Text('${venue.rating}', style: const TextStyle(color: FB.text, fontSize: 11, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 10),
                  const Icon(Icons.directions_walk_rounded, color: FB.muted, size: 14),
                  const SizedBox(width: 3),
                  Text('${venue.walkMinutes} min', style: const TextStyle(color: FB.muted, fontSize: 11)),
                ]),
              ])),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => store.toggleFavorite(venue.id),
                child: Padding(padding: const EdgeInsets.all(5), child: Icon(store.favorites.contains(venue.id) ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: store.favorites.contains(venue.id) ? FB.coral : FB.muted, size: 21)),
              ),
            ]),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11),
              decoration: BoxDecoration(color: FB.bg.withOpacity(.72), borderRadius: BorderRadius.circular(13)),
              child: Row(children: [
                const Icon(Icons.auto_awesome_rounded, color: FB.mint, size: 16),
                const SizedBox(width: 7),
                Expanded(child: Text(ranked.reason, style: const TextStyle(color: FB.text, fontSize: 11, fontWeight: FontWeight.w700))),
                Text('${ranked.match}% match', style: const TextStyle(color: FB.mint, fontSize: 11, fontWeight: FontWeight.w900)),
              ]),
            ),
            const SizedBox(height: 12),
            Row(children: [
              FlowTag(label: store.heavyTraffic ? '-${venue.discount}% FLASH PASS' : 'DEAL PAUSED', color: store.heavyTraffic ? FB.amber : FB.muted, icon: store.heavyTraffic ? Icons.bolt_rounded : null),
              const Spacer(),
              Text('from €${venue.price.toStringAsFixed(2)}', style: const TextStyle(color: FB.muted, fontSize: 10.5)),
              const SizedBox(width: 7),
              const Icon(Icons.arrow_forward_rounded, color: FB.mint, size: 17),
            ]),
          ]),
        ),
      ),
    );
  }
}

void showOfferSheet(BuildContext context, Pitstop venue) {
  final store = FlowBiteScope.of(context);
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: FB.card,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(31))),
    builder: (modalContext) => StatefulBuilder(builder: (modalContext, updateModal) {
      final claimed = store.claimedIds.contains(venue.id);
      final match = store.rank(venue);
      return SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(22, 2, 22, 20 + MediaQuery.of(modalContext).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            VenueSymbol(venue: venue, size: 66),
            const Spacer(),
            FlowTag(label: store.heavyTraffic ? '-${venue.discount}% LIVE' : 'DEAL PAUSED', color: store.heavyTraffic ? FB.amber : FB.muted, icon: Icons.bolt_rounded),
          ]),
          const SizedBox(height: 14),
          Text(venue.name, style: const TextStyle(color: FB.text, fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(venue.subtitle, style: const TextStyle(color: FB.muted, fontSize: 12)),
          const SizedBox(height: 14),
          Text(venue.detail, style: const TextStyle(color: FB.text, fontSize: 12.5, height: 1.5)),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _OfferStat(icon: Icons.directions_walk_rounded, value: '${venue.walkMinutes} min', label: 'Walk from route')),
            const SizedBox(width: 8),
            Expanded(child: _OfferStat(icon: Icons.hourglass_bottom_rounded, value: '${venue.dwellMinutes} min', label: 'Ideal visit')),
            const SizedBox(width: 8),
            Expanded(child: _OfferStat(icon: Icons.star_rounded, value: venue.rating.toStringAsFixed(1), label: 'Community rating')),
          ]),
          const SizedBox(height: 16),
          FlowPanel(color: const Color(0xFF183736), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.auto_awesome_rounded, color: FB.mint, size: 20),
            const SizedBox(width: 9),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${match.match}% RECOMMENDER MATCH', style: const TextStyle(color: FB.mint, fontSize: 10.5, fontWeight: FontWeight.w900, letterSpacing: .7)),
              const SizedBox(height: 5),
              Text('${match.reason}. FlowBite considers visit length, walking time, flash value and your preferences.', style: const TextStyle(color: FB.text, fontSize: 11.5, height: 1.45)),
            ])),
          ])),
          const SizedBox(height: 17),
          SizedBox(width: double.infinity, child: FlowButton(
            label: claimed ? 'Show my QR pass' : store.heavyTraffic ? 'Claim ${venue.discount}% flash pass' : 'Available during congestion',
            icon: claimed ? Icons.qr_code_2_rounded : Icons.confirmation_number_rounded,
            onPressed: () {
              if (claimed) {
                Navigator.of(modalContext).pop();
                showPassSheet(context, venue);
              } else if (store.heavyTraffic) {
                store.claim(venue.id);
                updateModal(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Flash deals activate when traffic is congested.')));
              }
            },
          )),
          if (claimed) ...[const SizedBox(height: 7), const Center(child: Text('Pass claimed! You can also find it under My passes.', style: TextStyle(color: FB.mint, fontSize: 11)))],
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, child: FlowButton(
            secondary: true, label: 'Preview walking route', icon: Icons.map_outlined,
            onPressed: () {
              Navigator.of(modalContext).pop();
              Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => FullRadarScreen(focusedVenueId: venue.id)));
            },
          )),
          const SizedBox(height: 10),
          const Center(child: Text('Sample business, prices and discounts • demo only', style: TextStyle(color: FB.muted, fontSize: 10))),
        ]),
      ));
    }),
  );
}

class _OfferStat extends StatelessWidget {
  final IconData icon;
  final String value, label;
  const _OfferStat({required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => FlowPanel(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 11), radius: 15, color: FB.elevated,
    child: Column(children: [
      Icon(icon, color: FB.amber, size: 18),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(color: FB.text, fontWeight: FontWeight.w900, fontSize: 13)),
      const SizedBox(height: 4),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: FB.muted, fontSize: 9)),
    ]),
  );
}
