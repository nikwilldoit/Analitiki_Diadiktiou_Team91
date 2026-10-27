import 'dart:math' as math;
import 'package:flutter/material.dart';

part 'core.dart';
part 'components.dart';
part 'passport.dart';
part 'discover.dart';
part 'planner.dart';
part 'community.dart';

void main() => runApp(const RoamApp());

class RoamApp extends StatefulWidget {
  const RoamApp({super.key});

  @override
  State<RoamApp> createState() => _RoamAppState();
}

class _RoamAppState extends State<RoamApp> {
  final RoamStore store = RoamStore();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoamScope(
      notifier: store,
      child: MaterialApp(
        title: 'ROAM • Your world, your story',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Palette.bg,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Palette.mint,
            brightness: Brightness.dark,
            surface: Palette.surface,
          ),
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.55, color: Palette.white),
            headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: Palette.white),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.2, color: Palette.white),
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Palette.white),
            bodyMedium: TextStyle(fontSize: 13, height: 1.48, color: Palette.muted),
          ),
        ),
        home: const RoamShell(),
      ),
    );
  }
}

class RoamShell extends StatefulWidget {
  const RoamShell({super.key});
  @override
  State<RoamShell> createState() => _RoamShellState();
}

class _RoamShellState extends State<RoamShell> {
  int page = 0;

  void goTo(int next) => setState(() => page = next);

  @override
  Widget build(BuildContext context) {
    final pages = [
      PassportScreen(onOpenPlanner: () => goTo(2)),
      const DiscoverScreen(),
      const PlannerScreen(),
      const CommunityScreen(),
    ];
    return Container(
      color: const Color(0xFF080F19),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 530),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Palette.bg,
            boxShadow: [BoxShadow(color: Color(0x77000000), blurRadius: 45)],
          ),
          child: Scaffold(
            body: IndexedStack(index: page, children: pages),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Palette.surface,
                border: Border(top: BorderSide(color: Palette.outline, width: 1)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 9, 10, 7),
                  child: Row(
                    children: [
                      _tab(0, Icons.public_rounded, 'Passport'),
                      _tab(1, Icons.explore_rounded, 'Discover'),
                      _tab(2, Icons.auto_awesome_rounded, 'Plan trip'),
                      _tab(3, Icons.groups_rounded, 'Community'),
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

  Widget _tab(int i, IconData icon, String label) {
    final active = i == page;
    return Expanded(
      child: InkWell(
        onTap: () => goTo(i),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 210),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active ? Palette.mint.withOpacity(.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 21, color: active ? Palette.mint : Palette.muted),
              const SizedBox(height: 5),
              Text(label, style: TextStyle(fontSize: 10, fontWeight: active ? FontWeight.w600 : FontWeight.w600, color: active ? Palette.mint : Palette.muted)),
            ],
          ),
        ),
      ),
    );
  }
}
