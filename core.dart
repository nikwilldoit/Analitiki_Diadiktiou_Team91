part of 'main.dart';

class Palette {
  static const bg = Color(0xFF0B1320);
  static const surface = Color(0xFF101D2C);
  static const raised = Color(0xFF162536);
  static const outline = Color(0xFF27384A);
  static const white = Color(0xFFF4F8F9);
  static const muted = Color(0xFF92A7B7);
  static const mint = Color(0xFF62E8C1);
  static const purple = Color(0xFFAA9BFF);
  static const orange = Color(0xFFFFBF79);
  static const pink = Color(0xFFF18FB0);
  static const blue = Color(0xFF78BFFF);
}

enum Stamp { none, visited, wishlist, planned }

enum TravelVibe { adventure, culture, food, relaxing }

extension TravelVibeX on TravelVibe {
  String get label => switch (this) {
    TravelVibe.adventure => 'Adventure',
    TravelVibe.culture => 'Culture',
    TravelVibe.food => 'Foodie',
    TravelVibe.relaxing => 'Relax',
  };
  IconData get icon => switch (this) {
    TravelVibe.adventure => Icons.terrain_rounded,
    TravelVibe.culture => Icons.museum_rounded,
    TravelVibe.food => Icons.restaurant_rounded,
    TravelVibe.relaxing => Icons.spa_rounded,
  };
}

class Destination {
  final String id;
  final String city;
  final String country;
  final String region;
  final String flag;
  final String description;
  final String highlight;
  final String tip;
  final int flightEstimate;
  final int dailyEstimate;
  final double lon;
  final double lat;
  final TravelVibe vibe;
  final Color color;
  final List<String> activities;

  const Destination({
    required this.id,
    required this.city,
    required this.country,
    required this.region,
    required this.flag,
    required this.description,
    required this.highlight,
    required this.tip,
    required this.flightEstimate,
    required this.dailyEstimate,
    required this.lon,
    required this.lat,
    required this.vibe,
    required this.color,
    required this.activities,
  });
}

class TripPick {
  final Destination place;
  final int estimate;
  final int match;
  final String why;
  const TripPick(this.place, this.estimate, this.match, this.why);
}

class TravelPost {
  final String id;
  final String name;
  final String initials;
  final String city;
  final String title;
  final String body;
  final String tag;
  final String when;
  final int likes;
  final Color color;
  const TravelPost({required this.id, required this.name, required this.initials, required this.city, required this.title, required this.body, required this.tag, required this.when, required this.likes, required this.color});
}

class DemoData {
  static const places = <Destination>[
    Destination(id:'gr',city:'Athens',country:'Greece',region:'Europe',flag:'🇬🇷',description:'Ancient streets, sunlit terraces and island escapes.',highlight:'Sunsets & history',tip:'Explore Anafiotika early in the morning.',flightEstimate:40,dailyEstimate:68,lon:23.72,lat:37.98,vibe:TravelVibe.culture,color:Palette.orange,activities:['Acropolis at sunrise','Walk around Plaka','Rooftop dinner in Monastiraki']),
    Destination(id:'fr',city:'Paris',country:'France',region:'Europe',flag:'🇫🇷',description:'Art, hidden cafés and timeless neighbourhoods.',highlight:'Art & atmosphere',tip:'Book small museums in advance and walk the Marais.',flightEstimate:150,dailyEstimate:123,lon:2.35,lat:48.85,vibe:TravelVibe.culture,color:Palette.pink,activities:['Explore Le Marais','Picnic by the Seine','Visit Musée d’Orsay']),
    Destination(id:'it',city:'Rome',country:'Italy',region:'Europe',flag:'🇮🇹',description:'A living museum with unforgettable food.',highlight:'History & pasta',tip:'Visit Trastevere for an evening food walk.',flightEstimate:115,dailyEstimate:92,lon:12.50,lat:41.90,vibe:TravelVibe.food,color:Palette.orange,activities:['Roman Forum walk','Taste pasta in Trastevere','Watch sunset at Pincio']),
    Destination(id:'es',city:'Barcelona',country:'Spain',region:'Europe',flag:'🇪🇸',description:'Creative architecture meets Mediterranean days.',highlight:'Culture & coast',tip:'Reserve the Sagrada Família ahead of time.',flightEstimate:160,dailyEstimate:93,lon:2.17,lat:41.39,vibe:TravelVibe.culture,color:Palette.pink,activities:['Explore Park Güell','Beach afternoon','Discover the Gothic Quarter']),
    Destination(id:'pt',city:'Lisbon',country:'Portugal',region:'Europe',flag:'🇵🇹',description:'Golden-hour viewpoints, tiled streets and ocean air.',highlight:'Colorful city days',tip:'Ride a tram early before crowds arrive.',flightEstimate:190,dailyEstimate:77,lon:-9.14,lat:38.72,vibe:TravelVibe.food,color:Palette.orange,activities:['Alfama walking route','Try pastel de nata','Sunset at Miradouro da Graça']),
    Destination(id:'is',city:'Reykjavík',country:'Iceland',region:'Europe',flag:'🇮🇸',description:'Dramatic waterfalls, geothermal pools and wild landscapes.',highlight:'Wild nature',tip:'Weather changes fast—keep a flexible road-trip plan.',flightEstimate:330,dailyEstimate:186,lon:-21.94,lat:64.15,vibe:TravelVibe.adventure,color:Palette.blue,activities:['Golden Circle road trip','Soak in a hot spring','Look for northern lights']),
    Destination(id:'jp',city:'Kyoto',country:'Japan',region:'Asia',flag:'🇯🇵',description:'Tranquil temples and lantern-lit alleys.',highlight:'Calm & culture',tip:'Take the first train to Fushimi Inari.',flightEstimate:740,dailyEstimate:105,lon:135.77,lat:35.01,vibe:TravelVibe.culture,color:Palette.pink,activities:['Fushimi Inari hike','Tea ceremony','Wander Gion after sunset']),
    Destination(id:'th',city:'Chiang Mai',country:'Thailand',region:'Asia',flag:'🇹🇭',description:'Mountain adventures, markets and warm hospitality.',highlight:'Nature & food',tip:'Plan hikes around the seasonal air-quality conditions.',flightEstimate:670,dailyEstimate:48,lon:98.98,lat:18.79,vibe:TravelVibe.adventure,color:Palette.mint,activities:['Walk the old city','Visit a cooking class','Explore forest trails']),
    Destination(id:'vn',city:'Hanoi',country:'Vietnam',region:'Asia',flag:'🇻🇳',description:'Street food and vivid city energy.',highlight:'Street-food heaven',tip:'Try a guided local street-food walk.',flightEstimate:680,dailyEstimate:43,lon:105.83,lat:21.03,vibe:TravelVibe.food,color:Palette.orange,activities:['Old Quarter food crawl','Explore Hoan Kiem Lake','Day trip to Ninh Binh']),
    Destination(id:'ca',city:'Vancouver',country:'Canada',region:'Americas',flag:'🇨🇦',description:'Ocean-front city backed by vast mountains.',highlight:'Mountains & sea',tip:'Try the seawall by bicycle.',flightEstimate:820,dailyEstimate:155,lon:-123.12,lat:49.28,vibe:TravelVibe.adventure,color:Palette.blue,activities:['Cycle Stanley Park','Explore Granville Island','Hike in North Vancouver']),
    Destination(id:'us',city:'New York',country:'USA',region:'Americas',flag:'🇺🇸',description:'Iconic skyline, culture and neighbourhood discoveries.',highlight:'Big-city energy',tip:'Explore one neighbourhood at a time.',flightEstimate:640,dailyEstimate:205,lon:-74.0,lat:40.71,vibe:TravelVibe.culture,color:Palette.purple,activities:['Walk the High Line','Explore Brooklyn','Catch a sunset skyline view']),
    Destination(id:'ma',city:'Marrakech',country:'Morocco',region:'Africa',flag:'🇲🇦',description:'Vibrant markets, garden courtyards and nearby desert.',highlight:'Markets & desert',tip:'Explore the medina with a local guide.',flightEstimate:210,dailyEstimate:68,lon:-8.0,lat:31.63,vibe:TravelVibe.adventure,color:Palette.orange,activities:['Explore Jemaa el-Fnaa','Atlas Mountains day trip','Visit Majorelle Garden']),
    Destination(id:'no',city:'Bergen',country:'Norway',region:'Europe',flag:'🇳🇴',description:'Wooden harbour lanes surrounded by misty fjords.',highlight:'Fjords & hiking',tip:'Bring a light rain jacket even in summer.',flightEstimate:260,dailyEstimate:160,lon:5.32,lat:60.39,vibe:TravelVibe.adventure,color:Palette.blue,activities:['See Bryggen','Take a fjord cruise','Hike Mount Fløyen']),
    Destination(id:'id',city:'Bali',country:'Indonesia',region:'Asia',flag:'🇮🇩',description:'Rice terraces, surf spots and peaceful retreats.',highlight:'Island reset',tip:'Pick one region instead of crossing the island daily.',flightEstimate:690,dailyEstimate:75,lon:115.19,lat:-8.40,vibe:TravelVibe.relaxing,color:Palette.mint,activities:['Ubud rice terraces','Watch the ocean sunset','Visit a waterfall']),
    Destination(id:'ch',city:'Lucerne',country:'Switzerland',region:'Europe',flag:'🇨🇭',description:'Lake views, alpine trains and snow-capped peaks.',highlight:'Alpine postcard',tip:'Rail passes can be worthwhile for multi-day trips.',flightEstimate:185,dailyEstimate:186,lon:8.31,lat:47.05,vibe:TravelVibe.relaxing,color:Palette.blue,activities:['Walk Chapel Bridge','Cruise Lake Lucerne','Explore Mount Pilatus']),
  ];

  static const posts = <TravelPost>[
    TravelPost(id:'p1',name:'Sofia L.',initials:'SL',city:'Kyoto, Japan',title:'Kyoto on a student budget: what actually worked',body:'I spent five days exploring quieter neighbourhoods, temples and local food spots. The biggest saving was staying near a train line instead of in the busiest district. My favourite morning: the Fushimi Inari paths before 8 AM.',tag:'Budget tips',when:'2h ago',likes:84,color:Palette.purple),
    TravelPost(id:'p2',name:'Alex M.',initials:'AM',city:'Iceland',title:'Three things I wish I knew before a road trip',body:'Build a flexible itinerary, check road conditions and never underestimate the weather. Our favourite day was an unplanned stop at a quiet waterfall. Also: budget more for meals than you expect.',tag:'Travel story',when:'Yesterday',likes:56,color:Palette.blue),
    TravelPost(id:'p3',name:'Maya T.',initials:'MT',city:'Lisbon, Portugal',title:'My favourite free viewpoints in Lisbon',body:'Miradouro da Graça at sunset, a slow walk through Alfama and the little streets near the castle made my trip. You can have a fantastic weekend without a packed schedule.',tag:'Hidden gems',when:'2 days ago',likes:121,color:Palette.orange),
    TravelPost(id:'p4',name:'Nikos P.',initials:'NP',city:'Rome, Italy',title:'A three-day Rome itinerary for food lovers',body:'Spend less time jumping between famous attractions and more time exploring each neighbourhood. Trastevere evenings were the highlight of our trip.',tag:'Itineraries',when:'4 days ago',likes:39,color:Palette.mint),
  ];
}

class RoamStore extends ChangeNotifier {
  final Map<String, Stamp> stamps = {
    'gr': Stamp.visited, 'fr': Stamp.visited, 'it': Stamp.visited,
    'es': Stamp.visited, 'pt': Stamp.visited, 'ca': Stamp.visited,
    'jp': Stamp.wishlist, 'is': Stamp.wishlist, 'id': Stamp.wishlist,
    'no': Stamp.wishlist, 'th': Stamp.planned,
  };
  final Set<String> likes = {};
  final List<TravelPost> customPosts = [];
  int budget = 1100;
  int days = 6;
  String companions = 'Couple';
  String region = 'Anywhere';
  String season = 'Anytime';
  TravelVibe vibe = TravelVibe.adventure;
  bool generated = false;

  Stamp status(String id) => stamps[id] ?? Stamp.none;
  int get visitedCount => stamps.values.where((s) => s == Stamp.visited).length;
  int get wishedCount => stamps.values.where((s) => s == Stamp.wishlist).length;
  int get plannedCount => stamps.values.where((s) => s == Stamp.planned).length;
  int get continentsVisited => DemoData.places.where((p) => status(p.id) == Stamp.visited).map((p) => p.region).toSet().length;

  void setStamp(String id, Stamp stamp) {
    if (stamp == Stamp.none) { stamps.remove(id); } else { stamps[id] = stamp; }
    notifyListeners();
  }
  void setBudget(double value) { budget = value.round(); notifyListeners(); }
  void setDays(double value) { days = value.round(); notifyListeners(); }
  void setCompanions(String value) { companions = value; notifyListeners(); }
  void setRegion(String value) { region = value; notifyListeners(); }
  void setSeason(String value) { season = value; notifyListeners(); }
  void setVibe(TravelVibe value) { vibe = value; notifyListeners(); }
  void generate() { generated = true; notifyListeners(); }
  void editTrip() { generated = false; notifyListeners(); }
  void toggleLike(String id) { likes.contains(id) ? likes.remove(id) : likes.add(id); notifyListeners(); }
  void addPost(TravelPost post) { customPosts.insert(0, post); notifyListeners(); }

  List<TripPick> get recommendations {
    final options = DemoData.places.where((p) => region == 'Anywhere' || p.region == region).toList();
    final seasonal = switch (season) {
      'Spring' => <String>{'jp','it','pt','es'},
      'Summer' => <String>{'gr','es','pt','id'},
      'Autumn' => <String>{'jp','fr','it','us'},
      'Winter' => <String>{'is','no','ch','th'},
      _ => <String>{},
    };
    final groupFit = switch (companions) {
      'Couple' => <String>{'fr','it','pt','id'},
      'Friends' => <String>{'es','us','th','gr'},
      'Family' => <String>{'ca','ch','gr','it'},
      _ => <String>{'jp','pt','vn','th'},
    };
    final results = options.map((p) {
      final estimated = p.flightEstimate + p.dailyEstimate * days;
      final afford = estimated <= budget;
      final vibeMatch = p.vibe == vibe;
      final wished = status(p.id) == Stamp.wishlist;
      final visited = status(p.id) == Stamp.visited;
      final budgetGap = ((estimated - budget).clamp(0, 2000) / 50).round();
      final score = (64 + (vibeMatch ? 18 : 0) + (wished ? 10 : 0) + (afford ? 12 : 0) + (seasonal.contains(p.id) ? 5 : 0) + (groupFit.contains(p.id) ? 4 : 0) - (visited ? 8 : 0) - budgetGap).clamp(40, 98).toInt();
      final why = wished ? 'On your dream list · ${p.highlight}' : vibeMatch ? 'Matches your ${vibe.label.toLowerCase()} style' : afford ? 'Fits your budget · ${p.highlight}' : '${p.highlight} · stretch option';
      return TripPick(p, estimated, score, why);
    }).toList()..sort((a,b) => b.match.compareTo(a.match));
    return results.take(5).toList();
  }
}

class RoamScope extends InheritedNotifier<RoamStore> {
  const RoamScope({super.key, required super.notifier, required super.child});
  static RoamStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RoamScope>();
    assert(scope != null, 'No RoamScope found');
    return scope!.notifier!;
  }
}
