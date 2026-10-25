part of 'main.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String query = '';
  String selected = 'All';

  @override
  Widget build(BuildContext context) {
    final data = MockData.offers.where((offer) {
      final q = query.toLowerCase();
      final matchText =
          offer.name.toLowerCase().contains(q) ||
          offer.category.toLowerCase().contains(q);
      final matchCategory = selected == 'All' || offer.category == selected;
      return matchText && matchCategory;
    }).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: [
          const ScreenHeading(
            eyebrow: 'RECOMMENDER',
            title: 'Discover smart stops',
            subtitle: 'Ranked by route fit, traffic timing and your preferences.',
          ),
          const SizedBox(height: 18),
          TextField(
            onChanged: (v) => setState(() => query = v),
            decoration: InputDecoration(
              hintText: 'Search coffee, food, places...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: const Icon(Icons.mic_none_rounded),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          CategoryStrip(
            selected: selected,
            onChanged: (v) => setState(() => selected = v),
          ),
          const SizedBox(height: 20),
          ...data.map(
            (offer) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OfferCard(
                offer: offer,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OfferDetailsScreen(offer: offer),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryStrip extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const CategoryStrip({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = ['All', 'Coffee', 'Food', 'Dessert', 'Shopping'];
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final item = items[i];
          final active = item == selected;
          return ChoiceChip(
            label: Text(item),
            selected: active,
            showCheckmark: false,
            selectedColor: const Color(0xFF171822),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: active ? Colors.white : const Color(0xFF61636E),
              fontWeight: FontWeight.w800,
            ),
            side: BorderSide.none,
            onSelected: (_) => onChanged(item),
          );
        },
      ),
    );
  }
}

class OfferDetailsScreen extends StatelessWidget {
  final Offer offer;

  const OfferDetailsScreen({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            Row(
              children: [
                AppIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                const AppIconButton(icon: Icons.favorite_border_rounded),
                const SizedBox(width: 8),
                const AppIconButton(icon: Icons.share_outlined),
              ],
            ),
            const SizedBox(height: 18),
            Hero(
              tag: offer.id,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      offer.accent.withOpacity(0.24),
                      offer.accent.withOpacity(0.07),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Icon(
                    offer.icon,
                    size: 78,
                    color: offer.accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    offer.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8F1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    offer.discount,
                    style: const TextStyle(
                      color: Color(0xFF278D61),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              offer.subtitle,
              style: const TextStyle(
                color: Color(0xFF7E808B),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: DetailMetric(
                    icon: Icons.star_rounded,
                    title: offer.rating.toStringAsFixed(1),
                    subtitle: '${offer.reviews} reviews',
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: DetailMetric(
                    icon: Icons.near_me_outlined,
                    title: offer.distance,
                    subtitle: 'from you',
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: DetailMetric(
                    icon: Icons.schedule_rounded,
                    title: offer.eta,
                    subtitle: 'walk',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EEFF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF6D5DFB),
                    child: Icon(Icons.auto_awesome_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'FlowBite recommends this stop because it fits your route and could save around ${offer.savedMinutes} minutes while traffic remains high.',
                      style: const TextStyle(
                        color: Color(0xFF66657A),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.navigation_rounded),
              label: const Text('Start route'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF171822),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailMetric extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const DetailMetric({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6D5DFB), size: 20),
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF171822),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF91939E),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

