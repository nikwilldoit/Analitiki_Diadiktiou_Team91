part of 'main.dart';

// All numbers, venue locations and forecasts are deliberately simulated.
// Replace this layer with prediction/recommendation APIs for a production app.
class Pitstop {
  final String id;
  final String name;
  final String category;
  final String subtitle;
  final String detail;
  final String offerLabel;
  final IconData icon;
  final Color accent;
  final int discount;
  final int walkMinutes;
  final int dwellMinutes;
  final double price;
  final double rating;
  final double mapX;
  final double mapY;

  const Pitstop({
    required this.id,
    required this.name,
    required this.category,
    required this.subtitle,
    required this.detail,
    required this.offerLabel,
    required this.icon,
    required this.accent,
    required this.discount,
    required this.walkMinutes,
    required this.dwellMinutes,
    required this.price,
    required this.rating,
    required this.mapX,
    required this.mapY,
  });
}

class RankedPitstop {
  final Pitstop venue;
  final int match;
  final String reason;
  const RankedPitstop(this.venue, this.match, this.reason);
}

const mockVenues = <Pitstop>[
  Pitstop(id: 'brew', name: 'Coffee Lab', category: 'Coffee', subtitle: 'Specialty coffee · calm corner', detail: 'A calm coffee break with fast service, comfortable seating and your drink ready in minutes.', offerLabel: 'FLASH COFFEE', icon: Icons.coffee_rounded, accent: FB.amber, discount: 30, walkMinutes: 4, dwellMinutes: 25, price: 4.2, rating: 4.9, mapX: .25, mapY: .31),
  Pitstop(id: 'nest', name: 'The Quiet Nest', category: 'Workspace', subtitle: 'Wi-Fi · power outlets · quiet', detail: 'A comfortable work booth with high-speed Wi-Fi, charging points and a relaxed atmosphere.', offerLabel: 'FOCUS PASS', icon: Icons.laptop_mac_rounded, accent: FB.violet, discount: 35, walkMinutes: 6, dwellMinutes: 32, price: 7.5, rating: 4.8, mapX: .73, mapY: .25),
  Pitstop(id: 'bites', name: 'Urban Bites', category: 'Food', subtitle: 'Fresh bowls · quick service', detail: 'Warm bowls and fresh wraps prepared quickly for commuters on a tight schedule.', offerLabel: 'LUNCH DROP', icon: Icons.ramen_dining_rounded, accent: FB.coral, discount: 25, walkMinutes: 7, dwellMinutes: 28, price: 8.8, rating: 4.7, mapX: .75, mapY: .65),
  Pitstop(id: 'green', name: 'Green Bowl', category: 'Food', subtitle: 'Plant-based · healthy bowls', detail: 'Fresh, plant-based dishes with seating for a productive midday stop.', offerLabel: 'GREEN HOUR', icon: Icons.eco_rounded, accent: FB.mint, discount: 20, walkMinutes: 5, dwellMinutes: 30, price: 7.2, rating: 4.8, mapX: .35, mapY: .75),
  Pitstop(id: 'work', name: 'Workroom 21', category: 'Workspace', subtitle: 'Desk space · espresso included', detail: 'Claim a short-session desk to recharge your devices and finish your work while the jam clears.', offerLabel: 'DESK FLASH', icon: Icons.chair_alt_rounded, accent: FB.violet, discount: 40, walkMinutes: 9, dwellMinutes: 35, price: 9.0, rating: 4.9, mapX: .55, mapY: .51),
  Pitstop(id: 'sweet', name: 'Sweet Spot', category: 'Dessert', subtitle: 'Bakes · waffles · soft serve', detail: 'A small sweet treat and a short break before traffic starts moving again.', offerLabel: 'SWEET ESCAPE', icon: Icons.icecream_rounded, accent: const Color(0xFFFF9FC9), discount: 20, walkMinutes: 8, dwellMinutes: 20, price: 5.9, rating: 4.8, mapX: .18, mapY: .58),
];

class FlowBiteStore extends ChangeNotifier {
  bool heavyTraffic = true;
  String category = 'All';
  bool coffeePreference = true;
  bool workspacePreference = true;
  bool foodPreference = true;
  bool budgetPreference = false;
  final Set<String> favorites = {'brew', 'nest'};
  final Set<String> claimedIds = {};

  int get congestion => heavyTraffic ? 88 : 18;
  int get clearance => heavyTraffic ? 35 : 0;
  int get confidence => heavyTraffic ? 94 : 97;
  int get estimatedSavings => heavyTraffic ? 22 : 0;
  int get driveNow => heavyTraffic ? 64 : 18;
  int get pauseAndGo => heavyTraffic ? 42 : 43;

  void toggleTraffic() {
    heavyTraffic = !heavyTraffic;
    notifyListeners();
  }

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setCoffee(bool value) { coffeePreference = value; notifyListeners(); }
  void setWorkspace(bool value) { workspacePreference = value; notifyListeners(); }
  void setFood(bool value) { foodPreference = value; notifyListeners(); }
  void setBudget(bool value) { budgetPreference = value; notifyListeners(); }

  void toggleFavorite(String id) {
    if (!favorites.add(id)) favorites.remove(id);
    notifyListeners();
  }

  void claim(String id) {
    claimedIds.add(id);
    notifyListeners();
  }

  Pitstop getVenue(String id) => mockVenues.firstWhere((venue) => venue.id == id);

  // Transparent demo recommender: fit to the predicted window + distance
  // + discount + personal taste. No trained model is running in this mockup.
  RankedPitstop rank(Pitstop venue) {
    final walking = venue.walkMinutes;
    final stop = venue.dwellMinutes;
    final preferred = switch (venue.category) {
      'Coffee' => coffeePreference,
      'Workspace' => workspacePreference,
      'Food' || 'Dessert' => foodPreference,
      _ => false,
    };
    final fitsWindow = heavyTraffic && (walking + stop <= clearance + 5);
    final distanceScore = (22 - walking * 2).clamp(0, 22);
    final timingScore = heavyTraffic
        ? (24 - (clearance - (walking + stop)).abs()).clamp(0, 24)
        : 9;
    final score = (29 + distanceScore + timingScore + (preferred ? 13 : 0) +
            (venue.discount / 5).round() + (budgetPreference && venue.price <= 7.5 ? 7 : 0))
        .clamp(42, 99)
        .toInt();
    final why = !heavyTraffic
        ? 'Near your route'
        : fitsWindow
            ? 'Fits your 35-min window'
            : preferred
                ? 'Matches your taste'
                : '${walking}-min walk from route';
    return RankedPitstop(venue, score, why);
  }

  List<RankedPitstop> get rankedVenues {
    final items = mockVenues
        .where((v) => category == 'All' || v.category == category)
        .where((v) => !budgetPreference || v.price <= 7.5)
        .map(rank)
        .toList();
    items.sort((a, b) => b.match.compareTo(a.match));
    return items;
  }
}

class FlowBiteScope extends InheritedNotifier<FlowBiteStore> {
  const FlowBiteScope({super.key, required super.notifier, required super.child});

  static FlowBiteStore of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<FlowBiteScope>();
    assert(inherited != null, 'FlowBiteScope is missing');
    return inherited!.notifier!;
  }
}
