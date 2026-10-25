import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

part 'data.dart';
part 'home.dart';
part 'discover.dart';
part 'traffic.dart';
part 'map.dart';
part 'profile_widgets.dart';

void main() => runApp(const FlowBiteApp());

abstract final class FB {
  static const bg = Color(0xFF07111B);
  static const card = Color(0xFF102331);
  static const elevated = Color(0xFF183141);
  static const mint = Color(0xFF6CF3C4);
  static const amber = Color(0xFFFFC16E);
  static const coral = Color(0xFFFF7286);
  static const violet = Color(0xFFAC9FFF);
  static const text = Color(0xFFF1F8FA);
  static const muted = Color(0xFF8EA3B2);
  static const line = Color(0xFF263C49);
}

class FlowBiteApp extends StatefulWidget {
  const FlowBiteApp({super.key});

  @override
  State<FlowBiteApp> createState() => _FlowBiteAppState();
}

class _FlowBiteAppState extends State<FlowBiteApp> {
  final FlowBiteStore store = FlowBiteStore();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: FB.mint,
      brightness: Brightness.dark,
      surface: FB.bg,
    );
    return FlowBiteScope(
      notifier: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlowBite • Make traffic time yours',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: FB.bg,
          colorScheme: scheme,
          fontFamily: 'Roboto',
          splashFactory: InkRipple.splashFactory,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -1.2, color: FB.text),
            headlineMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: -0.8, color: FB.text),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.4, color: FB.text),
            bodyMedium: TextStyle(fontSize: 14, color: FB.muted, height: 1.4),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: FB.elevated,
            contentTextStyle: const TextStyle(color: FB.text),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
        home: const FlowBiteShell(),
      ),
    );
  }
}

class FlowBiteShell extends StatefulWidget {
  const FlowBiteShell({super.key});

  @override
  State<FlowBiteShell> createState() => _FlowBiteShellState();
}

class _FlowBiteShellState extends State<FlowBiteShell> {
  int tab = 0;

  void navigate(int next) => setState(() => tab = next);

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      HomeScreen(onNavigate: navigate),
      DiscoverScreen(onNavigate: navigate),
      TrafficScreen(onNavigate: navigate),
      SavedProfileScreen(onNavigate: navigate),
    ];

    return Scaffold(
      extendBody: true,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: IndexedStack(index: tab, children: tabs),
        ),
      ),
      bottomNavigationBar: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xF0162A38),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: const Color(0xFF344958)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 32, offset: const Offset(0, 14))],
                  ),
                  child: NavigationBar(
                    height: 69,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    indicatorColor: FB.mint.withOpacity(.15),
                    selectedIndex: tab,
                    onDestinationSelected: navigate,
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.radar_outlined), selectedIcon: Icon(Icons.radar, color: FB.mint), label: 'Radar'),
                      NavigationDestination(icon: Icon(Icons.local_offer_outlined), selectedIcon: Icon(Icons.local_offer_rounded, color: FB.mint), label: 'Offers'),
                      NavigationDestination(icon: Icon(Icons.auto_graph_outlined), selectedIcon: Icon(Icons.auto_graph_rounded, color: FB.mint), label: 'Traffic AI'),
                      NavigationDestination(icon: Icon(Icons.bookmark_outline_rounded), selectedIcon: Icon(Icons.bookmark_rounded, color: FB.mint), label: 'My passes'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
