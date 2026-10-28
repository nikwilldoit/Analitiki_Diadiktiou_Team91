part of 'main.dart';

/// PART A: a clickable preview of a content-based recommendation experience.
/// All destinations, match scores and price estimates are deterministic mock data.
class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = RoamScope.of(context);
    return PageFrame(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: SectionHeading(
          label: 'ROAM · PERSONALIZED DISCOVERY',
          title: store.generated ? 'Made for you.' : 'Your next trip, decoded.',
          subtitle: store.generated
              ? 'A personal feed ranked using your passport, saved places and preferences.'
              : 'Like a travel version of your Netflix home page — destinations selected for you, not everyone.',
        )),
        if (store.generated)
          IconButton.filledTonal(
            onPressed: store.editTrip,
            tooltip: 'Edit trip preferences',
            icon: const Icon(Icons.tune_rounded, color: Palette.mint),
          ),
      ]),
      const SizedBox(height: 18),
      if (!store.generated) ...[
        const _RecommendationHero(),
        const SizedBox(height: 16),
        _TravelDnaCard(store: store),
        const SizedBox(height: 20),
        const _StepHeading(number: '01', title: 'Set the scene',
          subtitle: 'These details define what a good trip looks like right now.'),
        const SizedBox(height: 12),
        GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.account_balance_wallet_outlined, color: Palette.mint),
            const SizedBox(width: 9),
            const Expanded(child: Text('Budget per person', style: TextStyle(color: Palette.white, fontWeight: FontWeight.w700))),
            Text('€${store.budget}', style: const TextStyle(color: Palette.mint, fontSize: 19, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          Slider(
            value: store.budget.toDouble(), min: 300, max: 3500, divisions: 32,
            activeColor: Palette.mint, inactiveColor: Palette.outline,
            label: '€${store.budget}', onChanged: store.setBudget,
          ),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('€300', style: TextStyle(color: Palette.muted, fontSize: 10)),
            Text('€3,500', style: TextStyle(color: Palette.muted, fontSize: 10)),
          ]),
          const SizedBox(height: 12),
          const Text('Mock return-flight and daily-spending estimates, departing from Athens.',
            style: TextStyle(color: Palette.muted, fontSize: 11, height: 1.4)),
        ])),
        const SizedBox(height: 12),
        GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const _FieldLabel('TRAVELING WITH', Icons.people_alt_outlined),
          const SizedBox(height: 11),
          Wrap(spacing: 8, runSpacing: 8, children:
            ['Solo', 'Couple', 'Friends', 'Family'].map((v) => Pill(
              text: v, color: Palette.purple,
              selected: store.companions == v, onTap: () => store.setCompanions(v),
            )).toList()),
          const MiniDivider(),
          const _FieldLabel('YOUR SEARCH AREA', Icons.public_rounded),
          const SizedBox(height: 11),
          Wrap(spacing: 8, runSpacing: 8, children:
            ['Anywhere', 'Europe', 'Asia', 'Americas', 'Africa'].map((v) => Pill(
              text: v, color: Palette.mint,
              selected: store.region == v, onTap: () => store.setRegion(v),
            )).toList()),
          const MiniDivider(),
          const _FieldLabel('YOUR TRIP VIBE', Icons.auto_awesome_rounded),
          const SizedBox(height: 11),
          Wrap(spacing: 8, runSpacing: 8, children: TravelVibe.values.map((v) => Pill(
            text: v.label, icon: v.icon, color: Palette.orange,
            selected: store.vibe == v, onTap: () => store.setVibe(v),
          )).toList()),
          const MiniDivider(),
          const _FieldLabel('PREFERRED SEASON', Icons.calendar_month_rounded),
          const SizedBox(height: 11),
          Wrap(spacing: 8, runSpacing: 8, children:
            ['Anytime', 'Spring', 'Summer', 'Autumn', 'Winter'].map((v) => Pill(
              text: v, color: Palette.purple,
              selected: store.season == v, onTap: () => store.setSeason(v),
            )).toList()),
        ])),
        const SizedBox(height: 12),
        GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.timelapse_rounded, color: Palette.mint),
            const SizedBox(width: 10),
            const Expanded(child: Text('Trip duration', style: TextStyle(color: Palette.white, fontWeight: FontWeight.w700))),
            Text('${store.days} days', style: const TextStyle(color: Palette.mint, fontWeight: FontWeight.w700, fontSize: 17)),
          ]),
          const SizedBox(height: 7),
          Slider(value: store.days.toDouble(), min: 3, max: 14, divisions: 11,
            label: '${store.days} days', activeColor: Palette.mint,
            inactiveColor: Palette.outline, onChanged: store.setDays),
        ])),
        const SizedBox(height: 18),
        ActionButton(text: 'Reveal my travel matches', icon: Icons.auto_awesome_rounded,
          onTap: store.generate),
        const SizedBox(height: 12),
        const Center(child: Text('INTERACTIVE AI RECOMMENDER CONCEPT · DEMO DATA',
          textAlign: TextAlign.center,
          style: TextStyle(color: Palette.muted, fontSize: 9, letterSpacing: .45))),
      ] else ...[
        _ResultsSummary(store: store),
        const SizedBox(height: 15),
        _TravelDnaCard(store: store, compact: true),
        const SizedBox(height: 22),
        Row(children: [
          const Icon(Icons.auto_awesome_rounded, color: Palette.mint, size: 21),
          const SizedBox(width: 8),
          Expanded(child: Text('Recommended for you', style: Theme.of(context).textTheme.titleLarge)),
        ]),
        const SizedBox(height: 5),
        const Text('Ordered by your simulated personal match score.',
          style: TextStyle(color: Palette.muted, fontSize: 11.5)),
        const SizedBox(height: 12),
        if (store.recommendations.isEmpty)
          GlassCard(child: Column(children: [
            const Icon(Icons.travel_explore_rounded, color: Palette.muted, size: 32),
            const SizedBox(height: 8),
            const Text('No matches left in this region', style: TextStyle(color: Palette.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            const Text('Try another region or reset your feedback.', style: TextStyle(color: Palette.muted, fontSize: 11)),
            const SizedBox(height: 12),
            TextButton.icon(onPressed: store.clearTripFeedback,
              icon: const Icon(Icons.refresh_rounded), label: const Text('Reset feedback')),
          ])),
        ...store.recommendations.asMap().entries.map((entry) => Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: _PersonalizedTripCard(
            key: ValueKey(entry.value.place.id),
            result: entry.value, featured: entry.key == 0,
          ),
        )),
        const SizedBox(height: 5),
        GlassCard(color: const Color(0xFF19283A), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(children: [
              Icon(Icons.psychology_outlined, color: Palette.purple, size: 20),
              SizedBox(width: 9),
              Expanded(child: Text('How recommendations adapt',
                style: TextStyle(color: Palette.white, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 9),
            const Text('Tap "More like this" or "Not for me" on any destination. ROAM reranks the feed using your feedback, your map history and current travel choices.',
              style: TextStyle(color: Palette.muted, height: 1.5, fontSize: 12)),
            const SizedBox(height: 9),
            Text('${store.positiveTripSignals} positive feedback signal(s) in this demo',
              style: const TextStyle(color: Palette.mint, fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 9),
            TextButton.icon(
              onPressed: store.clearTripFeedback,
              icon: const Icon(Icons.restart_alt_rounded, size: 17),
              label: const Text('Reset my recommendation feedback'),
            ),
          ],
        )),
        const SizedBox(height: 15),
        const Text('PART A MOCKUP · Rule-based scores, fictional costs, no trained AI or live booking data.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Palette.muted, fontSize: 10, height: 1.5)),
        const SizedBox(height: 13),
        ActionButton(text: 'Adjust my trip', icon: Icons.tune_rounded,
          onTap: store.editTrip, filled: false),
      ],
    ]);
  }
}

class _RecommendationHero extends StatelessWidget {
  const _RecommendationHero();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(19),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Color(0xFF244A50), Color(0xFF1A2C46), Color(0xFF302846)],
      ),
      border: Border.all(color: const Color(0xFF3A5B63)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.auto_awesome_rounded, color: Palette.mint, size: 17),
        SizedBox(width: 7),
        Text('ROAM RECOMMENDATION ENGINE',
          style: TextStyle(color: Palette.mint, fontSize: 10,
            letterSpacing: 1.15, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 13),
      const Text('Destinations that\nget you.', style: TextStyle(
        color: Palette.white, fontSize: 28, height: 1.1,
        letterSpacing: -.7, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      const Text('Your travel history becomes your taste profile. Your dreams and trip choices shape your next recommendations.',
        style: TextStyle(color: Color(0xFFC4D7DE), fontSize: 12, height: 1.52)),
      const SizedBox(height: 15),
      Wrap(spacing: 7, runSpacing: 7, children: const [
        _SignalChip(Icons.public_rounded, 'Your passport', Palette.mint),
        _SignalChip(Icons.favorite_rounded, 'Your dream list', Palette.purple),
        _SignalChip(Icons.tune_rounded, 'Your preferences', Palette.orange),
      ]),
    ]),
  );
}

class _SignalChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SignalChip(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(color: Palette.bg.withOpacity(.45),
      borderRadius: BorderRadius.circular(30)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: color, size: 14),
      const SizedBox(width: 5),
      Text(label, style: const TextStyle(color: Palette.white,
        fontSize: 10.5, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _TravelDnaCard extends StatelessWidget {
  final RoamStore store;
  final bool compact;
  const _TravelDnaCard({required this.store, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final interest = store.inferredInterests;
    final top = store.topTravelInterest;
    final maxValue = interest.values.fold<double>(1, (a, b) => math.max(a, b));
    return GlassCard(color: const Color(0xFF172739), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(Icons.fingerprint_rounded, color: Palette.purple, size: 21),
          const SizedBox(width: 9),
          const Expanded(child: Text('Your travel DNA', style: TextStyle(
            color: Palette.white, fontSize: 16, fontWeight: FontWeight.w700))),
          Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(color: Palette.purple.withOpacity(.13),
              borderRadius: BorderRadius.circular(9)),
            child: const Text('PERSONALIZED', style: TextStyle(
              color: Palette.purple, fontSize: 8.5, fontWeight: FontWeight.w700,
              letterSpacing: .6))),
        ]),
        const SizedBox(height: 10),
        Text('Based on ${store.visitedCount} visited, ${store.wishedCount} wishlist and ${store.positiveTripSignals} liked trips.',
          style: const TextStyle(color: Palette.muted, fontSize: 11.5)),
        const SizedBox(height: 10),
        Row(children: [
          const Text('Your strongest interest:', style: TextStyle(color: Palette.muted, fontSize: 11)),
          const SizedBox(width: 6),
          Icon(top.icon, size: 14, color: Palette.mint),
          const SizedBox(width: 5),
          Text(top.label, style: const TextStyle(color: Palette.mint,
            fontSize: 11, fontWeight: FontWeight.w700)),
        ]),
        if (!compact) ...[
          const SizedBox(height: 17),
          ...TravelVibe.values.map((v) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              SizedBox(width: 72, child: Text(v.label,
                style: const TextStyle(color: Palette.muted, fontSize: 11))),
              Expanded(child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  minHeight: 7,
                  value: (interest[v]! / maxValue).clamp(0, 1).toDouble(),
                  color: v == top ? Palette.mint : Palette.purple,
                  backgroundColor: Palette.outline,
                ),
              )),
            ]),
          )),
          const SizedBox(height: 4),
          const Text('Try adding a country to your Wishlist in Passport — this profile changes immediately.',
            style: TextStyle(color: Palette.muted, fontSize: 10.5, height: 1.4)),
        ],
      ],
    ));
  }
}

class _StepHeading extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  const _StepHeading({required this.number, required this.title,
    required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(width: 37, height: 37,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Palette.mint.withOpacity(.12),
          borderRadius: BorderRadius.circular(12)),
        child: Text(number, style: const TextStyle(color: Palette.mint,
          fontWeight: FontWeight.w700, fontSize: 12))),
      const SizedBox(width: 11),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Palette.white,
            fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(color: Palette.muted, fontSize: 11.5)),
        ])),
    ],
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  const _FieldLabel(this.text, this.icon);
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, color: Palette.mint, size: 18),
    const SizedBox(width: 8),
    Text(text, style: const TextStyle(color: Palette.white,
      fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: .8)),
  ]);
}

class _ResultsSummary extends StatelessWidget {
  final RoamStore store;
  const _ResultsSummary({required this.store});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(23),
      gradient: const LinearGradient(colors: [Color(0xFF1C4851), Color(0xFF1A2C48)])),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.auto_awesome_rounded, color: Palette.mint, size: 18),
        SizedBox(width: 8),
        Text('YOUR PERSONAL FEED', style: TextStyle(color: Palette.mint,
          fontSize: 10, letterSpacing: 1.05, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 11),
      Text('€${store.budget} · ${store.days} days · ${store.companions}',
        style: const TextStyle(color: Palette.white,
          fontSize: 19, fontWeight: FontWeight.w700)),
      const SizedBox(height: 9),
      Wrap(spacing: 7, runSpacing: 7, children: [
        Pill(text: store.region, selected: true),
        Pill(text: store.vibe.label, color: Palette.orange, selected: true),
        Pill(text: store.season, color: Palette.purple, selected: true),
      ]),
      const SizedBox(height: 12),
      const Text('Illustrative cost per person · Assumed origin: Athens',
        style: TextStyle(color: Palette.muted, fontSize: 10.5)),
    ]),
  );
}

class _PersonalizedTripCard extends StatelessWidget {
  final TripPick result;
  final bool featured;
  const _PersonalizedTripCard({super.key, required this.result, required this.featured});

  @override
  Widget build(BuildContext context) {
    final p = result.place;
    final store = RoamScope.of(context);
    final interested = store.tripFeedback[p.id] == 1;
    return GlassCard(
      padding: const EdgeInsets.all(13),
      color: featured ? const Color(0xFF1A2E3A) : Palette.surface,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (featured) ...[
          const Row(children: [
            Icon(Icons.verified_rounded, color: Palette.mint, size: 17),
            SizedBox(width: 6),
            Text('YOUR #1 MATCH', style: TextStyle(color: Palette.mint,
              fontSize: 10, letterSpacing: 1.1, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
        ],
        GestureDetector(onTap: () => openPlace(context, p),
          child: LandscapeArt(place: p, height: featured ? 170 : 125)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: Text('${p.flag} ${p.city}',
            style: const TextStyle(color: Palette.white,
              fontSize: 19, fontWeight: FontWeight.w700))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(color: Palette.mint.withOpacity(.13),
              borderRadius: BorderRadius.circular(11)),
            child: Text('${result.match}% match', style: const TextStyle(
              color: Palette.mint, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ]),
        const SizedBox(height: 5),
        Text(result.why, style: const TextStyle(color: Palette.muted, fontSize: 11.5)),
        const SizedBox(height: 12),
        Row(children: [
          const Text('EST. TRIP', style: TextStyle(color: Palette.muted,
            fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: .5)),
          const SizedBox(width: 8),
          Text('€${result.estimate}', style: const TextStyle(color: Palette.white,
            fontSize: 19, fontWeight: FontWeight.w700)),
          const Text(' / person', style: TextStyle(color: Palette.muted, fontSize: 10)),
          const Spacer(),
          IconButton(
            tooltip: 'Save to dream list',
            onPressed: () => store.setStamp(p.id,
              store.status(p.id) == Stamp.wishlist ? Stamp.none : Stamp.wishlist),
            icon: Icon(store.status(p.id) == Stamp.wishlist
              ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: Palette.purple),
          ),
          IconButton(tooltip: 'Destination details',
            onPressed: () => openPlace(context, p),
            icon: const Icon(Icons.arrow_forward_rounded, color: Palette.mint)),
        ]),
        const SizedBox(height: 6),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            dense: true,
            iconColor: Palette.mint, collapsedIconColor: Palette.muted,
            title: const Row(children: [
              Icon(Icons.lightbulb_outline_rounded, color: Palette.orange, size: 17),
              SizedBox(width: 7),
              Text('Why this trip?', style: TextStyle(color: Palette.white,
                fontSize: 12, fontWeight: FontWeight.w700)),
            ]),
            children: [
              Align(alignment: Alignment.centerLeft, child: Wrap(
                spacing: 6, runSpacing: 7,
                children: result.reasons.map((reason) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                  decoration: BoxDecoration(color: Palette.raised,
                    borderRadius: BorderRadius.circular(11)),
                  child: Text(reason, style: const TextStyle(
                    color: Palette.white, fontSize: 10.5)),
                )).toList(),
              )),
              const SizedBox(height: 12),
              _MatchingFactor('Chosen travel vibe', result.preferenceFit, 23, Palette.orange),
              const SizedBox(height: 9),
              _MatchingFactor('Travel passport signals', result.historyFit, 15, Palette.purple),
              const SizedBox(height: 9),
              _MatchingFactor('Budget fit', result.affordabilityFit, 16, Palette.mint),
              const SizedBox(height: 9),
              const Text('Illustrative content-based scoring, not a trained model.',
                style: TextStyle(color: Palette.muted, fontSize: 10.5)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(children: [
          Expanded(child: OutlinedButton.icon(
            onPressed: () => store.reactToTrip(p.id, true),
            icon: Icon(interested ? Icons.check_circle_rounded : Icons.thumb_up_alt_outlined,
              color: interested ? Palette.mint : Palette.white, size: 16),
            label: Text(interested ? 'Liked' : 'More like this',
              style: TextStyle(color: interested ? Palette.mint : Palette.white,
                fontSize: 11, fontWeight: FontWeight.w700)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
              side: BorderSide(color: interested ? Palette.mint : Palette.outline),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            ),
          )),
          const SizedBox(width: 9),
          Expanded(child: OutlinedButton.icon(
            onPressed: () => store.reactToTrip(p.id, false),
            icon: const Icon(Icons.thumb_down_alt_outlined, color: Palette.muted, size: 16),
            label: const Text('Not for me', style: TextStyle(
              color: Palette.muted, fontSize: 11, fontWeight: FontWeight.w700)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
              side: const BorderSide(color: Palette.outline),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            ),
          )),
        ]),
      ]),
    );
  }
}

class _MatchingFactor extends StatelessWidget {
  final String title;
  final int score;
  final int maxScore;
  final Color color;
  const _MatchingFactor(this.title, this.score, this.maxScore, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [
    SizedBox(width: 143, child: Text(title,
      style: const TextStyle(color: Palette.muted, fontSize: 10.5))),
    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: (score / maxScore).clamp(0, 1).toDouble(),
        minHeight: 6, backgroundColor: Palette.outline, color: color,
      ),
    )),
  ]);
}
