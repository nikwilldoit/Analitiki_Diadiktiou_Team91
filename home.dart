part of 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: [
          const TopHeader(),
          const SizedBox(height: 22),
          const HeroTrafficCard(),
          const SizedBox(height: 24),
          const QuickActions(),
          const SizedBox(height: 30),
          const SectionTitle(
            title: 'Recommended nearby',
            subtitle: 'Smart stops based on traffic and your route',
          ),
          const SizedBox(height: 14),
          ...MockData.offers.take(3).map(
            (offer) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
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
          const SizedBox(height: 8),
          const AiExplanationCard(),
        ],
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FLOWBITE',
                style: TextStyle(
                  color: Color(0xFF6D5DFB),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Good afternoon 👋',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 15,
                    color: Color(0xFF92949F),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Athens · Kifisias',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF92949F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const AppIconButton(icon: Icons.notifications_none_rounded),
      ],
    );
  }
}

class HeroTrafficCard extends StatelessWidget {
  const HeroTrafficCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF151620),
            Color(0xFF292A43),
            Color(0xFF5C4DE1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5C4DE1).withOpacity(0.22),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SoftBadge(
                icon: Icons.auto_awesome_rounded,
                label: 'AI PREDICTION',
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF55DFA2).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Color(0xFF55DFA2),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: Color(0xFFC5F8DE),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Traffic will remain heavy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kifisias Avenue · Northbound',
            style: TextStyle(
              color: Color(0xFFC8C8D5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '34',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  height: 0.94,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2.4,
                ),
              ),
              const SizedBox(width: 6),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'min',
                  style: TextStyle(
                    color: Color(0xFFB7B8C6),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF171822),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.bolt_rounded, size: 18),
                label: const Text(
                  'Find a stop',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Row(
            children: [
              Expanded(
                child: HeroMetric(
                  icon: Icons.schedule_rounded,
                  value: '+24m',
                  label: 'Delay',
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: HeroMetric(
                  icon: Icons.query_stats_rounded,
                  value: '91%',
                  label: 'Confidence',
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: HeroMetric(
                  icon: Icons.near_me_rounded,
                  value: '4m',
                  label: 'Best stop',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeroMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const HeroMetric({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: const Color(0xFFD9DAE5)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFAEB0BE),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: QuickActionCard(
            icon: Icons.coffee_rounded,
            title: 'Coffee',
            subtitle: '12 nearby',
            accent: Color(0xFF7A68FF),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: QuickActionCard(
            icon: Icons.restaurant_rounded,
            title: 'Food',
            subtitle: '18 nearby',
            accent: Color(0xFFFF8066),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: QuickActionCard(
            icon: Icons.shopping_bag_rounded,
            title: 'Shop',
            subtitle: '8 nearby',
            accent: Color(0xFF47B887),
          ),
        ),
      ],
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: Color(0xFF171822),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF91939E),
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class AiExplanationCard extends StatelessWidget {
  const AiExplanationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFF6D5DFB),
            child: Icon(Icons.auto_awesome_rounded, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why these recommendations?',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF29283D),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'FlowBite ranks nearby places using predicted traffic duration, distance, active offers and your saved preferences.',
                  style: TextStyle(
                    color: Color(0xFF66657A),
                    height: 1.4,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

