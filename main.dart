import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const FlowBiteApp());

class FlowBiteApp extends StatelessWidget {
  const FlowBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowBite',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D5DFB),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            color: Color(0xFF15161F),
          ),
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.9,
            color: Color(0xFF15161F),
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF15161F),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.45,
            color: Color(0xFF747681),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class Offer {
  final String id;
  final String name;
  final String category;
  final String discount;
  final String subtitle;
  final String distance;
  final String eta;
  final double rating;
  final int reviews;
  final int savedMinutes;
  final IconData icon;
  final Color accent;

  const Offer({
    required this.id,
    required this.name,
    required this.category,
    required this.discount,
    required this.subtitle,
    required this.distance,
    required this.eta,
    required this.rating,
    required this.reviews,
    required this.savedMinutes,
    required this.icon,
    required this.accent,
  });
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      TrafficScreen(),
      DiscoverScreen(),
      MapScreen(),
      SavedScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(18, 0, 18, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 32,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: NavigationBar(
                height: 74,
                backgroundColor: Colors.transparent,
                elevation: 0,
                indicatorColor: const Color(0xFFEDEAFF),
                selectedIndex: index,
                onDestinationSelected: (v) => setState(() => index = v),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.route_outlined),
                    selectedIcon: Icon(Icons.route_rounded),
                    label: 'Traffic',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore_rounded),
                    label: 'Discover',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map_rounded),
                    label: 'Map',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_border_rounded),
                    selectedIcon: Icon(Icons.favorite_rounded),
                    label: 'Saved',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MockData {
  static const offers = <Offer>[
    Offer(
      id: 'coffee-lab',
      name: 'Coffee Lab',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Specialty coffee · Quiet seating',
      distance: '350 m',
      eta: '4 min',
      rating: 4.8,
      reviews: 321,
      savedMinutes: 18,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'urban-bites',
      name: 'Urban Bites',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Healthy bowls · Fast service',
      distance: '600 m',
      eta: '7 min',
      rating: 4.7,
      reviews: 287,
      savedMinutes: 15,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'sweet-spot',
      name: 'Sweet Spot',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Dessert · Ice cream · Waffles',
      distance: '900 m',
      eta: '10 min',
      rating: 4.9,
      reviews: 418,
      savedMinutes: 12,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'green-bowl',
      name: 'Green Bowl',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Fresh bowls · Vegan options',
      distance: '750 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 198,
      savedMinutes: 11,
      icon: Icons.eco_rounded,
      accent: Color(0xFF47B887),
    ),
  ];
}

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

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF898B96),
          ),
        ),
      ],
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onTap;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Hero(
                tag: offer.id,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        offer.accent.withOpacity(0.20),
                        offer.accent.withOpacity(0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Icon(
                    offer.icon,
                    color: offer.accent,
                    size: 31,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: Color(0xFF171822),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF8A8C97),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        TinyInfo(
                          icon: Icons.near_me_outlined,
                          text: offer.distance,
                        ),
                        const SizedBox(width: 9),
                        TinyInfo(
                          icon: Icons.directions_walk_rounded,
                          text: offer.eta,
                        ),
                        const SizedBox(width: 9),
                        TinyInfo(
                          icon: Icons.star_rounded,
                          text: offer.rating.toStringAsFixed(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF8F1),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text(
                  offer.discount,
                  style: const TextStyle(
                    color: Color(0xFF278D61),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TinyInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const TinyInfo({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF9A9CA6)),
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF70727D),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: [
          const ScreenHeading(
            eyebrow: 'YOUR SPACE',
            title: 'Saved places',
            subtitle: 'Favorites ready for the next traffic delay.',
          ),
          const SizedBox(height: 20),
          ...MockData.offers.map(
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool traffic = true;
  bool offers = true;
  bool ranking = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: [
          const ScreenHeading(
            eyebrow: 'ACCOUNT',
            title: 'Your profile',
            subtitle: 'Control your recommendations and alerts.',
          ),
          const SizedBox(height: 20),
          const ProfileCard(),
          const SizedBox(height: 20),
          SettingsTile(
            icon: Icons.traffic_rounded,
            title: 'Traffic alerts',
            subtitle: 'Tell me when congestion is likely to last',
            value: traffic,
            onChanged: (v) => setState(() => traffic = v),
          ),
          const SizedBox(height: 10),
          SettingsTile(
            icon: Icons.local_offer_rounded,
            title: 'Instant offers',
            subtitle: 'Show relevant nearby live deals',
            value: offers,
            onChanged: (v) => setState(() => offers = v),
          ),
          const SizedBox(height: 10),
          SettingsTile(
            icon: Icons.auto_awesome_rounded,
            title: 'Personalized ranking',
            subtitle: 'Use your preferences for smarter ranking',
            value: ranking,
            onChanged: (v) => setState(() => ranking = v),
          ),
          const SizedBox(height: 22),
          const ProfileMenuItem(
            icon: Icons.restaurant_menu_rounded,
            title: 'Food preferences',
          ),
          const SizedBox(height: 10),
          const ProfileMenuItem(
            icon: Icons.location_on_outlined,
            title: 'Location settings',
          ),
          const SizedBox(height: 10),
          const ProfileMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6D5DFB), Color(0xFF9B8CFF)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 33,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michalis',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Color(0xFF171822),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Athens, Greece',
                  style: TextStyle(
                    color: Color(0xFF8A8C97),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Personalization active',
                  style: TextStyle(
                    color: Color(0xFF6D5DFB),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.edit_outlined, color: Color(0xFF8A8C97)),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 11, 10, 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF6D5DFB), size: 20),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF171822),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8A8C97),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F8),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, size: 19),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
          color: Color(0xFF9799A4),
        ),
      ),
    );
  }
}

class ScreenHeading extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;

  const ScreenHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: Color(0xFF6D5DFB),
            fontSize: 10.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 5),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF858792),
            fontSize: 13.5,
            height: 1.4,
          ),
        ),
      ],
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

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ?? () {},
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, size: 21, color: const Color(0xFF343640)),
        ),
      ),
    );
  }
}

class SoftBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const SoftBadge({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFD8D9E4)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFD8D9E4),
              fontSize: 10,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
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

class ExtendedMockCatalog {
  static const extraOffers = <Offer>[
    Offer(
      id: 'athens-1',
      name: 'Athens Spot 1',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '289 m',
      eta: '4 min',
      rating: 4.2,
      reviews: 74,
      savedMinutes: 9,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-2',
      name: 'Athens Spot 2',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '298 m',
      eta: '5 min',
      rating: 4.3,
      reviews: 78,
      savedMinutes: 10,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-3',
      name: 'Athens Spot 3',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '307 m',
      eta: '6 min',
      rating: 4.4,
      reviews: 82,
      savedMinutes: 11,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-4',
      name: 'Athens Spot 4',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '316 m',
      eta: '7 min',
      rating: 4.5,
      reviews: 86,
      savedMinutes: 12,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-5',
      name: 'Athens Spot 5',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '325 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 90,
      savedMinutes: 13,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-6',
      name: 'Athens Spot 6',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '334 m',
      eta: '9 min',
      rating: 4.7,
      reviews: 94,
      savedMinutes: 14,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-7',
      name: 'Athens Spot 7',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '343 m',
      eta: '10 min',
      rating: 4.8,
      reviews: 98,
      savedMinutes: 15,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-8',
      name: 'Athens Spot 8',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '352 m',
      eta: '11 min',
      rating: 4.1,
      reviews: 102,
      savedMinutes: 16,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-9',
      name: 'Athens Spot 9',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '361 m',
      eta: '12 min',
      rating: 4.2,
      reviews: 106,
      savedMinutes: 17,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-10',
      name: 'Athens Spot 10',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '370 m',
      eta: '13 min',
      rating: 4.3,
      reviews: 110,
      savedMinutes: 18,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-11',
      name: 'Athens Spot 11',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '379 m',
      eta: '14 min',
      rating: 4.4,
      reviews: 114,
      savedMinutes: 19,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-12',
      name: 'Athens Spot 12',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '388 m',
      eta: '3 min',
      rating: 4.5,
      reviews: 118,
      savedMinutes: 20,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-13',
      name: 'Athens Spot 13',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '397 m',
      eta: '4 min',
      rating: 4.6,
      reviews: 122,
      savedMinutes: 21,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-14',
      name: 'Athens Spot 14',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '406 m',
      eta: '5 min',
      rating: 4.7,
      reviews: 126,
      savedMinutes: 22,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-15',
      name: 'Athens Spot 15',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '415 m',
      eta: '6 min',
      rating: 4.8,
      reviews: 130,
      savedMinutes: 23,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-16',
      name: 'Athens Spot 16',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '424 m',
      eta: '7 min',
      rating: 4.1,
      reviews: 134,
      savedMinutes: 24,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-17',
      name: 'Athens Spot 17',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '433 m',
      eta: '8 min',
      rating: 4.2,
      reviews: 138,
      savedMinutes: 8,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-18',
      name: 'Athens Spot 18',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '442 m',
      eta: '9 min',
      rating: 4.3,
      reviews: 142,
      savedMinutes: 9,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-19',
      name: 'Athens Spot 19',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '451 m',
      eta: '10 min',
      rating: 4.4,
      reviews: 146,
      savedMinutes: 10,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-20',
      name: 'Athens Spot 20',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '460 m',
      eta: '11 min',
      rating: 4.5,
      reviews: 150,
      savedMinutes: 11,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-21',
      name: 'Athens Spot 21',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '469 m',
      eta: '12 min',
      rating: 4.6,
      reviews: 154,
      savedMinutes: 12,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-22',
      name: 'Athens Spot 22',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '478 m',
      eta: '13 min',
      rating: 4.7,
      reviews: 158,
      savedMinutes: 13,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-23',
      name: 'Athens Spot 23',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '487 m',
      eta: '14 min',
      rating: 4.8,
      reviews: 162,
      savedMinutes: 14,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-24',
      name: 'Athens Spot 24',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '496 m',
      eta: '3 min',
      rating: 4.1,
      reviews: 166,
      savedMinutes: 15,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-25',
      name: 'Athens Spot 25',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '505 m',
      eta: '4 min',
      rating: 4.2,
      reviews: 170,
      savedMinutes: 16,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-26',
      name: 'Athens Spot 26',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '514 m',
      eta: '5 min',
      rating: 4.3,
      reviews: 174,
      savedMinutes: 17,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-27',
      name: 'Athens Spot 27',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '523 m',
      eta: '6 min',
      rating: 4.4,
      reviews: 178,
      savedMinutes: 18,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-28',
      name: 'Athens Spot 28',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '532 m',
      eta: '7 min',
      rating: 4.5,
      reviews: 182,
      savedMinutes: 19,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-29',
      name: 'Athens Spot 29',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '541 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 186,
      savedMinutes: 20,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-30',
      name: 'Athens Spot 30',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '550 m',
      eta: '9 min',
      rating: 4.7,
      reviews: 190,
      savedMinutes: 21,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-31',
      name: 'Athens Spot 31',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '559 m',
      eta: '10 min',
      rating: 4.8,
      reviews: 194,
      savedMinutes: 22,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-32',
      name: 'Athens Spot 32',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '568 m',
      eta: '11 min',
      rating: 4.1,
      reviews: 198,
      savedMinutes: 23,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-33',
      name: 'Athens Spot 33',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '577 m',
      eta: '12 min',
      rating: 4.2,
      reviews: 202,
      savedMinutes: 24,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-34',
      name: 'Athens Spot 34',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '586 m',
      eta: '13 min',
      rating: 4.3,
      reviews: 206,
      savedMinutes: 8,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-35',
      name: 'Athens Spot 35',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '595 m',
      eta: '14 min',
      rating: 4.4,
      reviews: 210,
      savedMinutes: 9,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-36',
      name: 'Athens Spot 36',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '604 m',
      eta: '3 min',
      rating: 4.5,
      reviews: 214,
      savedMinutes: 10,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-37',
      name: 'Athens Spot 37',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '613 m',
      eta: '4 min',
      rating: 4.6,
      reviews: 218,
      savedMinutes: 11,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-38',
      name: 'Athens Spot 38',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '622 m',
      eta: '5 min',
      rating: 4.7,
      reviews: 222,
      savedMinutes: 12,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-39',
      name: 'Athens Spot 39',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '631 m',
      eta: '6 min',
      rating: 4.8,
      reviews: 226,
      savedMinutes: 13,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-40',
      name: 'Athens Spot 40',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '640 m',
      eta: '7 min',
      rating: 4.1,
      reviews: 230,
      savedMinutes: 14,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-41',
      name: 'Athens Spot 41',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '649 m',
      eta: '8 min',
      rating: 4.2,
      reviews: 234,
      savedMinutes: 15,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-42',
      name: 'Athens Spot 42',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '658 m',
      eta: '9 min',
      rating: 4.3,
      reviews: 238,
      savedMinutes: 16,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-43',
      name: 'Athens Spot 43',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '667 m',
      eta: '10 min',
      rating: 4.4,
      reviews: 242,
      savedMinutes: 17,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-44',
      name: 'Athens Spot 44',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '676 m',
      eta: '11 min',
      rating: 4.5,
      reviews: 246,
      savedMinutes: 18,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-45',
      name: 'Athens Spot 45',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '685 m',
      eta: '12 min',
      rating: 4.6,
      reviews: 250,
      savedMinutes: 19,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-46',
      name: 'Athens Spot 46',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '694 m',
      eta: '13 min',
      rating: 4.7,
      reviews: 254,
      savedMinutes: 20,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-47',
      name: 'Athens Spot 47',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '703 m',
      eta: '14 min',
      rating: 4.8,
      reviews: 258,
      savedMinutes: 21,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-48',
      name: 'Athens Spot 48',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '712 m',
      eta: '3 min',
      rating: 4.1,
      reviews: 262,
      savedMinutes: 22,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-49',
      name: 'Athens Spot 49',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '721 m',
      eta: '4 min',
      rating: 4.2,
      reviews: 266,
      savedMinutes: 23,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-50',
      name: 'Athens Spot 50',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '730 m',
      eta: '5 min',
      rating: 4.3,
      reviews: 270,
      savedMinutes: 24,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-51',
      name: 'Athens Spot 51',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '739 m',
      eta: '6 min',
      rating: 4.4,
      reviews: 274,
      savedMinutes: 8,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-52',
      name: 'Athens Spot 52',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '748 m',
      eta: '7 min',
      rating: 4.5,
      reviews: 278,
      savedMinutes: 9,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-53',
      name: 'Athens Spot 53',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '757 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 282,
      savedMinutes: 10,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-54',
      name: 'Athens Spot 54',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '766 m',
      eta: '9 min',
      rating: 4.7,
      reviews: 286,
      savedMinutes: 11,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-55',
      name: 'Athens Spot 55',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '775 m',
      eta: '10 min',
      rating: 4.8,
      reviews: 290,
      savedMinutes: 12,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-56',
      name: 'Athens Spot 56',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '784 m',
      eta: '11 min',
      rating: 4.1,
      reviews: 294,
      savedMinutes: 13,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-57',
      name: 'Athens Spot 57',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '793 m',
      eta: '12 min',
      rating: 4.2,
      reviews: 298,
      savedMinutes: 14,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-58',
      name: 'Athens Spot 58',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '802 m',
      eta: '13 min',
      rating: 4.3,
      reviews: 302,
      savedMinutes: 15,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-59',
      name: 'Athens Spot 59',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '811 m',
      eta: '14 min',
      rating: 4.4,
      reviews: 306,
      savedMinutes: 16,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-60',
      name: 'Athens Spot 60',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '820 m',
      eta: '3 min',
      rating: 4.5,
      reviews: 310,
      savedMinutes: 17,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-61',
      name: 'Athens Spot 61',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '829 m',
      eta: '4 min',
      rating: 4.6,
      reviews: 314,
      savedMinutes: 18,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-62',
      name: 'Athens Spot 62',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '838 m',
      eta: '5 min',
      rating: 4.7,
      reviews: 318,
      savedMinutes: 19,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-63',
      name: 'Athens Spot 63',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '847 m',
      eta: '6 min',
      rating: 4.8,
      reviews: 322,
      savedMinutes: 20,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-64',
      name: 'Athens Spot 64',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '856 m',
      eta: '7 min',
      rating: 4.1,
      reviews: 326,
      savedMinutes: 21,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-65',
      name: 'Athens Spot 65',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '865 m',
      eta: '8 min',
      rating: 4.2,
      reviews: 330,
      savedMinutes: 22,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-66',
      name: 'Athens Spot 66',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '874 m',
      eta: '9 min',
      rating: 4.3,
      reviews: 334,
      savedMinutes: 23,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-67',
      name: 'Athens Spot 67',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '883 m',
      eta: '10 min',
      rating: 4.4,
      reviews: 338,
      savedMinutes: 24,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-68',
      name: 'Athens Spot 68',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '892 m',
      eta: '11 min',
      rating: 4.5,
      reviews: 342,
      savedMinutes: 8,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-69',
      name: 'Athens Spot 69',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '901 m',
      eta: '12 min',
      rating: 4.6,
      reviews: 346,
      savedMinutes: 9,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-70',
      name: 'Athens Spot 70',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '910 m',
      eta: '13 min',
      rating: 4.7,
      reviews: 350,
      savedMinutes: 10,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-71',
      name: 'Athens Spot 71',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '919 m',
      eta: '14 min',
      rating: 4.8,
      reviews: 354,
      savedMinutes: 11,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-72',
      name: 'Athens Spot 72',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '928 m',
      eta: '3 min',
      rating: 4.1,
      reviews: 358,
      savedMinutes: 12,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-73',
      name: 'Athens Spot 73',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '937 m',
      eta: '4 min',
      rating: 4.2,
      reviews: 362,
      savedMinutes: 13,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-74',
      name: 'Athens Spot 74',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '946 m',
      eta: '5 min',
      rating: 4.3,
      reviews: 366,
      savedMinutes: 14,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-75',
      name: 'Athens Spot 75',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '955 m',
      eta: '6 min',
      rating: 4.4,
      reviews: 370,
      savedMinutes: 15,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-76',
      name: 'Athens Spot 76',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '964 m',
      eta: '7 min',
      rating: 4.5,
      reviews: 374,
      savedMinutes: 16,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-77',
      name: 'Athens Spot 77',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '973 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 378,
      savedMinutes: 17,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-78',
      name: 'Athens Spot 78',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '982 m',
      eta: '9 min',
      rating: 4.7,
      reviews: 382,
      savedMinutes: 18,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-79',
      name: 'Athens Spot 79',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '991 m',
      eta: '10 min',
      rating: 4.8,
      reviews: 386,
      savedMinutes: 19,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-80',
      name: 'Athens Spot 80',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1000 m',
      eta: '11 min',
      rating: 4.1,
      reviews: 390,
      savedMinutes: 20,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-81',
      name: 'Athens Spot 81',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1009 m',
      eta: '12 min',
      rating: 4.2,
      reviews: 394,
      savedMinutes: 21,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-82',
      name: 'Athens Spot 82',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1018 m',
      eta: '13 min',
      rating: 4.3,
      reviews: 398,
      savedMinutes: 22,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-83',
      name: 'Athens Spot 83',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1027 m',
      eta: '14 min',
      rating: 4.4,
      reviews: 402,
      savedMinutes: 23,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-84',
      name: 'Athens Spot 84',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1036 m',
      eta: '3 min',
      rating: 4.5,
      reviews: 406,
      savedMinutes: 24,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-85',
      name: 'Athens Spot 85',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1045 m',
      eta: '4 min',
      rating: 4.6,
      reviews: 410,
      savedMinutes: 8,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-86',
      name: 'Athens Spot 86',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1054 m',
      eta: '5 min',
      rating: 4.7,
      reviews: 414,
      savedMinutes: 9,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-87',
      name: 'Athens Spot 87',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1063 m',
      eta: '6 min',
      rating: 4.8,
      reviews: 418,
      savedMinutes: 10,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-88',
      name: 'Athens Spot 88',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1072 m',
      eta: '7 min',
      rating: 4.1,
      reviews: 422,
      savedMinutes: 11,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-89',
      name: 'Athens Spot 89',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1081 m',
      eta: '8 min',
      rating: 4.2,
      reviews: 426,
      savedMinutes: 12,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-90',
      name: 'Athens Spot 90',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1090 m',
      eta: '9 min',
      rating: 4.3,
      reviews: 430,
      savedMinutes: 13,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-91',
      name: 'Athens Spot 91',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1099 m',
      eta: '10 min',
      rating: 4.4,
      reviews: 434,
      savedMinutes: 14,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-92',
      name: 'Athens Spot 92',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1108 m',
      eta: '11 min',
      rating: 4.5,
      reviews: 438,
      savedMinutes: 15,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-93',
      name: 'Athens Spot 93',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1117 m',
      eta: '12 min',
      rating: 4.6,
      reviews: 442,
      savedMinutes: 16,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-94',
      name: 'Athens Spot 94',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1126 m',
      eta: '13 min',
      rating: 4.7,
      reviews: 446,
      savedMinutes: 17,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-95',
      name: 'Athens Spot 95',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1135 m',
      eta: '14 min',
      rating: 4.8,
      reviews: 450,
      savedMinutes: 18,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-96',
      name: 'Athens Spot 96',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1144 m',
      eta: '3 min',
      rating: 4.1,
      reviews: 454,
      savedMinutes: 19,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-97',
      name: 'Athens Spot 97',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1153 m',
      eta: '4 min',
      rating: 4.2,
      reviews: 458,
      savedMinutes: 20,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-98',
      name: 'Athens Spot 98',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1162 m',
      eta: '5 min',
      rating: 4.3,
      reviews: 462,
      savedMinutes: 21,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-99',
      name: 'Athens Spot 99',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1171 m',
      eta: '6 min',
      rating: 4.4,
      reviews: 466,
      savedMinutes: 22,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-100',
      name: 'Athens Spot 100',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1180 m',
      eta: '7 min',
      rating: 4.5,
      reviews: 470,
      savedMinutes: 23,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-101',
      name: 'Athens Spot 101',
      category: 'Coffee',
      discount: '20% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1189 m',
      eta: '8 min',
      rating: 4.6,
      reviews: 474,
      savedMinutes: 24,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-102',
      name: 'Athens Spot 102',
      category: 'Food',
      discount: '25% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1198 m',
      eta: '9 min',
      rating: 4.7,
      reviews: 478,
      savedMinutes: 8,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-103',
      name: 'Athens Spot 103',
      category: 'Dessert',
      discount: '30% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1207 m',
      eta: '10 min',
      rating: 4.8,
      reviews: 482,
      savedMinutes: 9,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-104',
      name: 'Athens Spot 104',
      category: 'Shopping',
      discount: '2 FOR 1',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1216 m',
      eta: '11 min',
      rating: 4.1,
      reviews: 486,
      savedMinutes: 10,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-105',
      name: 'Athens Spot 105',
      category: 'Coffee',
      discount: '15% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1225 m',
      eta: '12 min',
      rating: 4.2,
      reviews: 490,
      savedMinutes: 11,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-106',
      name: 'Athens Spot 106',
      category: 'Food',
      discount: '20% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1234 m',
      eta: '13 min',
      rating: 4.3,
      reviews: 494,
      savedMinutes: 12,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-107',
      name: 'Athens Spot 107',
      category: 'Dessert',
      discount: '25% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1243 m',
      eta: '14 min',
      rating: 4.4,
      reviews: 498,
      savedMinutes: 13,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-108',
      name: 'Athens Spot 108',
      category: 'Shopping',
      discount: '30% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1252 m',
      eta: '3 min',
      rating: 4.5,
      reviews: 502,
      savedMinutes: 14,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-109',
      name: 'Athens Spot 109',
      category: 'Coffee',
      discount: '2 FOR 1',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1261 m',
      eta: '4 min',
      rating: 4.6,
      reviews: 506,
      savedMinutes: 15,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-110',
      name: 'Athens Spot 110',
      category: 'Food',
      discount: '15% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1270 m',
      eta: '5 min',
      rating: 4.7,
      reviews: 510,
      savedMinutes: 16,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-111',
      name: 'Athens Spot 111',
      category: 'Dessert',
      discount: '20% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1279 m',
      eta: '6 min',
      rating: 4.8,
      reviews: 514,
      savedMinutes: 17,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-112',
      name: 'Athens Spot 112',
      category: 'Shopping',
      discount: '25% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1288 m',
      eta: '7 min',
      rating: 4.1,
      reviews: 518,
      savedMinutes: 18,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-113',
      name: 'Athens Spot 113',
      category: 'Coffee',
      discount: '30% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1297 m',
      eta: '8 min',
      rating: 4.2,
      reviews: 522,
      savedMinutes: 19,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-114',
      name: 'Athens Spot 114',
      category: 'Food',
      discount: '2 FOR 1',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1306 m',
      eta: '9 min',
      rating: 4.3,
      reviews: 526,
      savedMinutes: 20,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-115',
      name: 'Athens Spot 115',
      category: 'Dessert',
      discount: '15% OFF',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1315 m',
      eta: '10 min',
      rating: 4.4,
      reviews: 530,
      savedMinutes: 21,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-116',
      name: 'Athens Spot 116',
      category: 'Shopping',
      discount: '20% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1324 m',
      eta: '11 min',
      rating: 4.5,
      reviews: 534,
      savedMinutes: 22,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
    Offer(
      id: 'athens-117',
      name: 'Athens Spot 117',
      category: 'Coffee',
      discount: '25% OFF',
      subtitle: 'Curated coffee stop · Smart route match',
      distance: '1333 m',
      eta: '12 min',
      rating: 4.6,
      reviews: 538,
      savedMinutes: 23,
      icon: Icons.coffee_rounded,
      accent: Color(0xFF7968FF),
    ),
    Offer(
      id: 'athens-118',
      name: 'Athens Spot 118',
      category: 'Food',
      discount: '30% OFF',
      subtitle: 'Curated food stop · Smart route match',
      distance: '1342 m',
      eta: '13 min',
      rating: 4.7,
      reviews: 542,
      savedMinutes: 24,
      icon: Icons.restaurant_rounded,
      accent: Color(0xFFFF8066),
    ),
    Offer(
      id: 'athens-119',
      name: 'Athens Spot 119',
      category: 'Dessert',
      discount: '2 FOR 1',
      subtitle: 'Curated dessert stop · Smart route match',
      distance: '1351 m',
      eta: '14 min',
      rating: 4.8,
      reviews: 546,
      savedMinutes: 8,
      icon: Icons.icecream_rounded,
      accent: Color(0xFFFF6EAC),
    ),
    Offer(
      id: 'athens-120',
      name: 'Athens Spot 120',
      category: 'Shopping',
      discount: '15% OFF',
      subtitle: 'Curated shopping stop · Smart route match',
      distance: '1360 m',
      eta: '3 min',
      rating: 4.1,
      reviews: 550,
      savedMinutes: 9,
      icon: Icons.shopping_bag_rounded,
      accent: Color(0xFFF2B84B),
    ),
  ];
}

class ModernInfoTile1 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile1({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile2 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile2({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile3 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile3({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile4 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile4({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile5 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile5({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile6 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile6({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile7 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile7({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile8 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile8({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile9 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile9({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile10 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile10({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile11 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile11({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile12 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile12({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile13 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile13({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile14 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile14({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile15 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile15({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile16 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile16({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile17 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile17({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile18 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile18({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile19 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile19({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}


class ModernInfoTile20 extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ModernInfoTile20({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D5DFB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF171822),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6D5DFB),
            ),
          ),
        ],
      ),
    );
  }
}
