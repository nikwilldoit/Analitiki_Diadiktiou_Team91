part of 'main.dart';

class PageFrame extends StatelessWidget {
  final List<Widget> children;
  const PageFrame({super.key, required this.children});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
      children: children,
    ),
  );
}

class SectionHeading extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  const SectionHeading({super.key, required this.label, required this.title, this.subtitle, this.trailing});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label.toUpperCase(), style: const TextStyle(color: Palette.mint, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineMedium)), if (trailing != null) trailing!]),
      if (subtitle != null) ...[const SizedBox(height: 6), Text(subtitle!, style: const TextStyle(color: Palette.muted, height: 1.45, fontSize: 12.5))],
    ],
  );
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback? onTap;
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(17), this.color = Palette.surface, this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: color,
    borderRadius: BorderRadius.circular(23),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(23),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), border: Border.all(color: Palette.outline.withOpacity(.72))),
        child: child,
      ),
    ),
  );
}

class Pill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;
  final bool selected;
  final VoidCallback? onTap;
  const Pill({super.key, required this.text, this.icon, this.color = Palette.mint, this.selected = false, this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(99),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(.18) : Palette.raised,
        border: Border.all(color: selected ? color.withOpacity(.8) : Palette.outline),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 15, color: selected ? color : Palette.muted), const SizedBox(width: 6)],
        Text(text, style: TextStyle(fontSize: 11.5, color: selected ? color : Palette.white, fontWeight: FontWeight.w600)),
      ]),
    ),
  );
}

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  const ActionButton({super.key, required this.text, required this.icon, required this.onTap, this.filled = true});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 51,
    child: FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: .15)),
      style: FilledButton.styleFrom(
        backgroundColor: filled ? Palette.mint : Palette.raised,
        foregroundColor: filled ? Palette.bg : Palette.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

class StatBox extends StatelessWidget {
  final String number;
  final String label;
  final Color color;
  const StatBox({super.key, required this.number, required this.label, this.color = Palette.white});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 7),
      decoration: BoxDecoration(color: Palette.raised, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        Text(number, style: TextStyle(color: color, fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -1)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Palette.muted, fontSize: 10.5, fontWeight: FontWeight.w700)),
      ]),
    ),
  );
}

class LandscapeArt extends StatelessWidget {
  final Destination place;
  final double height;
  final bool caption;
  const LandscapeArt({super.key, required this.place, this.height = 160, this.caption = true});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Stack(fit: StackFit.expand, children: [
        CustomPaint(painter: LandscapePainter(place.color, place.vibe)),
        Positioned(top: 12, left: 12, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(color: Palette.bg.withOpacity(.58), borderRadius: BorderRadius.circular(99)),
          child: Text('${place.flag} ${place.country}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        )),
        if (caption) Positioned(left: 16, bottom: 13, right: 12, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(place.city, style: const TextStyle(fontSize: 24, letterSpacing: -.8, fontWeight: FontWeight.w700, color: Colors.white)),
          Text(place.highlight, style: const TextStyle(color: Color(0xFFECF4F3), fontWeight: FontWeight.w600, fontSize: 11)),
        ])),
      ]),
    ),
  );
}

class LandscapePainter extends CustomPainter {
  final Color accent;
  final TravelVibe vibe;
  const LandscapePainter(this.accent, this.vibe);
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final sky = Paint()..shader = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [accent.withOpacity(.72), const Color(0xFF15283C), const Color(0xFF0C182A)],
    ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);
    final glow = Paint()..color = Palette.orange.withOpacity(.55);
    canvas.drawCircle(Offset(w * .79, h * .26), h * .21, glow);
    final far = Path()..moveTo(0, h*.76)..lineTo(w*.15,h*.45)..lineTo(w*.32,h*.71)..lineTo(w*.52,h*.32)..lineTo(w*.76,h*.73)..lineTo(w*.9,h*.53)..lineTo(w,h*.73)..lineTo(w,h)..lineTo(0,h)..close();
    canvas.drawPath(far, Paint()..color = const Color(0xFF274B59).withOpacity(.68));
    final near = Path()..moveTo(0,h*.83)..lineTo(w*.22,h*.61)..lineTo(w*.42,h*.91)..lineTo(w*.65,h*.6)..lineTo(w*.9,h*.88)..lineTo(w,h*.77)..lineTo(w,h)..lineTo(0,h)..close();
    canvas.drawPath(near, Paint()..color = const Color(0xFF0B2131).withOpacity(.90));
    if (vibe == TravelVibe.culture || vibe == TravelVibe.food) {
      final paint = Paint()..color=const Color(0xFF121D32).withOpacity(.7);
      for (var i=0;i<14;i++) {
        final x = w*(i/13);
        final buildingH = h*(.08+(i%4)*.04);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x,h*.84-buildingH, w*.07,buildingH+h*.3), const Radius.circular(2)), paint);
      }
    }
    final stars = Paint()..color=Colors.white.withOpacity(.48);
    for (var i=0;i<24;i++) { final x=w*((i*47%97)/97), y=h*((i*23%41)/100); canvas.drawCircle(Offset(x,y), i%5==0?1.35:.75,stars); }
    canvas.drawRect(Rect.fromLTWH(0,h*.68,w,h*.32),Paint()..shader=const LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,Color(0xCC05111E)]).createShader(Rect.fromLTWH(0,h*.68,w,h*.32)));
  }
  @override
  bool shouldRepaint(covariant LandscapePainter old) => old.accent!=accent || old.vibe!=vibe;
}

class PlaceCard extends StatelessWidget {
  final Destination place;
  final String? detail;
  const PlaceCard({super.key, required this.place, this.detail});
  @override
  Widget build(BuildContext context) {
    final store = RoamScope.of(context);
    final stamp = store.status(place.id);
    return GlassCard(
      onTap: () => openPlace(context, place),
      padding: const EdgeInsets.all(11),
      child: Row(children: [
        SizedBox(width: 112, child: LandscapeArt(place: place, height: 103, caption: false)),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${place.flag} ${place.city}', style: const TextStyle(color: Palette.white,fontWeight: FontWeight.w700,fontSize: 17)),
          const SizedBox(height: 4),
          Text(place.highlight, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Palette.muted,fontSize: 11)),
          const SizedBox(height: 9),
          if(detail!=null) Text(detail!,style:const TextStyle(color:Palette.mint,fontSize:11,fontWeight:FontWeight.w600))
          else Text(stampLabel(stamp),style:TextStyle(color:stampColor(stamp),fontSize:11,fontWeight:FontWeight.w600)),
        ])),
        const Icon(Icons.chevron_right_rounded,color:Palette.muted),
      ]),
    );
  }
}

String stampLabel(Stamp status) => switch(status) {
  Stamp.visited => '✓ Visited', Stamp.wishlist => '✦ Dream list', Stamp.planned => '◷ Planned', Stamp.none => '+ Add to passport',
};
Color stampColor(Stamp status) => switch(status) {
  Stamp.visited => Palette.mint, Stamp.wishlist => Palette.purple, Stamp.planned => Palette.orange, Stamp.none => Palette.muted,
};

void openPlace(BuildContext context, Destination place) {
  showModalBottomSheet<void>(
    context: context, isScrollControlled: true, backgroundColor: Palette.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    builder: (sheetContext) {
      final store = RoamScope.of(sheetContext);
      return FractionallySizedBox(heightFactor: .83, child: SafeArea(top: false, child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: Container(width: 42,height: 4,decoration:BoxDecoration(color:Palette.outline,borderRadius:BorderRadius.circular(20)))),
          const SizedBox(height: 20),
          LandscapeArt(place: place,height: 200),
          const SizedBox(height: 20),
          Text('${place.flag} ${place.city}, ${place.country}',style:Theme.of(sheetContext).textTheme.headlineMedium),
          const SizedBox(height: 7),
          Text(place.description,style:const TextStyle(color:Palette.muted,height:1.5)),
          const SizedBox(height: 18),
          const Text('ADD TO YOUR WORLD',style:TextStyle(color:Palette.mint,letterSpacing:1.3,fontSize:10,fontWeight:FontWeight.w700)),
          const SizedBox(height: 9),
          Wrap(spacing:8,runSpacing:8,children:[
            Pill(text:'Visited',icon:Icons.check_circle_outline,color:Palette.mint,selected:store.status(place.id)==Stamp.visited,onTap:()=>store.setStamp(place.id,Stamp.visited)),
            Pill(text:'Wishlist',icon:Icons.favorite_border,color:Palette.purple,selected:store.status(place.id)==Stamp.wishlist,onTap:()=>store.setStamp(place.id,Stamp.wishlist)),
            Pill(text:'Planned',icon:Icons.calendar_month_outlined,color:Palette.orange,selected:store.status(place.id)==Stamp.planned,onTap:()=>store.setStamp(place.id,Stamp.planned)),
            Pill(text:'Clear',icon:Icons.close_rounded,selected:store.status(place.id)==Stamp.none,onTap:()=>store.setStamp(place.id,Stamp.none)),
          ]),
          const SizedBox(height: 21),
          Text('The ROAM shortlist',style:Theme.of(sheetContext).textTheme.titleLarge),
          const SizedBox(height: 9),
          ...place.activities.map((a)=>Padding(padding:const EdgeInsets.symmetric(vertical:6),child:Row(children:[const Icon(Icons.check_rounded,color:Palette.mint,size:18),const SizedBox(width:10),Expanded(child:Text(a,style:const TextStyle(color:Palette.white,fontSize:12.5)))]))),
          const SizedBox(height: 15),
          GlassCard(color:Palette.raised,child:Row(children:[const Icon(Icons.lightbulb_outline_rounded,color:Palette.orange),const SizedBox(width:11),Expanded(child:Text(place.tip,style:const TextStyle(color:Palette.white,height:1.4,fontSize:12)))])),
          const SizedBox(height: 12),
          const Text('Illustrative travel ideas. No live pricing or booking.',style:TextStyle(color:Palette.muted,fontSize:10)),
        ],
      )));
    },
  );
}

class MiniDivider extends StatelessWidget {
  const MiniDivider({super.key});
  @override
  Widget build(BuildContext context) => const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Palette.outline, height: 1));
}


// PART A / ROAM COPILOT: conversational interactive preview.
// No remote LLM, flights API or external packages. Guided actions update
// the same RoamStore used by Plan Trip, so the prototype behaves coherently.
class RoamCopilotLauncher extends StatelessWidget {
  final VoidCallback onSeeMatches;
  const RoamCopilotLauncher({super.key, required this.onSeeMatches});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => RoamCopilotSheet(onSeeMatches: onSeeMatches),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 16, 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF62E8C1), Color(0xFF83D9EE)]),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [BoxShadow(color: Palette.mint.withOpacity(.25), blurRadius: 24, offset: const Offset(0, 9))],
          ),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.auto_awesome_rounded, color: Color(0xFF102233), size: 20),
            SizedBox(width: 8),
            Text('Ask ROAM', style: TextStyle(color: Color(0xFF102233), fontSize: 12, fontWeight: FontWeight.w800)),
          ]),
        ),
      ),
    );
  }
}

class _CopilotMessage {
  final bool fromUser;
  final String body;
  const _CopilotMessage(this.fromUser, this.body);
}

class RoamCopilotSheet extends StatefulWidget {
  final VoidCallback onSeeMatches;
  const RoamCopilotSheet({super.key, required this.onSeeMatches});
  @override
  State<RoamCopilotSheet> createState() => _RoamCopilotSheetState();
}

class _RoamCopilotSheetState extends State<RoamCopilotSheet> {
  final TextEditingController input = TextEditingController();
  final ScrollController scroll = ScrollController();
  final List<_CopilotMessage> messages = [
    const _CopilotMessage(false, 'Hey, explorer! ✨ I can help you turn your travel dreams into a plan. What are you in the mood for?'),
  ];
  bool showMatches = false;

  @override
  void dispose() { input.dispose(); scroll.dispose(); super.dispose(); }

  void _talk(String question, String answer, {VoidCallback? action, bool matches = false}) {
    action?.call();
    setState(() {
      messages.add(_CopilotMessage(true, question));
      messages.add(_CopilotMessage(false, answer));
      showMatches = matches;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scroll.hasClients) scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
    });
  }

  void _handleText() {
    final text = input.text.trim();
    if (text.isEmpty) return;
    input.clear();
    final store = RoamScope.of(context);
    final q = text.toLowerCase();
    if (q.contains('budget') || q.contains('cheap') || q.contains('€') || q.contains('affordable')) {
      _talk(text, 'We can optimize for your budget. Right now it is €${store.budget} per person. Try a quick budget below or open your personalized matches.');
    } else if (q.contains('beach') || q.contains('relax') || q.contains('sea')) {
      _talk(text, 'A relaxed escape sounds perfect. I’ve selected Relax as your travel style, so your matches will lean toward laid-back destinations.', action: () => store.setVibe(TravelVibe.relaxing), matches: true);
    } else if (q.contains('food') || q.contains('eat')) {
      _talk(text, 'Food-first trip? Love that. I’ve set your vibe to Foodie. Your ranked recommendations will now reflect that.', action: () => store.setVibe(TravelVibe.food), matches: true);
    } else if (q.contains('culture') || q.contains('museum') || q.contains('city')) {
      _talk(text, 'Let’s discover cultural gems. I’ve adjusted your vibe to Culture — check your updated travel matches.', action: () => store.setVibe(TravelVibe.culture), matches: true);
    } else if (q.contains('adventure') || q.contains('hike') || q.contains('nature')) {
      _talk(text, 'Adventure mode activated! I’ll prioritize outdoor destinations in your personalized results.', action: () => store.setVibe(TravelVibe.adventure), matches: true);
    } else {
      _talk(text, 'I’m a guided AI-assistant preview for Part A, not a live chatbot yet. Choose one of the interactive ideas below and I’ll adjust your trip recommendations.');
    }
  }

  Widget _chip(String text, IconData icon, VoidCallback onTap) {
    return ActionChip(
      onPressed: onTap,
      avatar: Icon(icon, color: Palette.mint, size: 16),
      label: Text(text, style: const TextStyle(color: Palette.white, fontSize: 11, fontWeight: FontWeight.w600)),
      backgroundColor: Palette.raised,
      side: const BorderSide(color: Palette.outline),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = RoamScope.of(context);
    final matches = store.recommendations;
    final height = MediaQuery.of(context).size.height * .82;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            color: Palette.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            border: Border(top: BorderSide(color: Palette.outline)),
          ),
          child: Column(children: [
            Container(width: 38, height: 4, margin: const EdgeInsets.only(top: 11, bottom: 13), decoration: BoxDecoration(color: Palette.outline, borderRadius: BorderRadius.circular(8))),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 2, 12, 14),
              child: Row(children: [
                Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: Palette.mint.withOpacity(.14), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.auto_awesome_rounded, color: Palette.mint)),
                const SizedBox(width: 11),
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('ROAM Copilot', style: TextStyle(color: Palette.white, fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 3),
                  Text('Personal travel companion · Interactive demo', style: TextStyle(color: Palette.muted, fontSize: 10.5)),
                ])),
                IconButton(icon: const Icon(Icons.close_rounded, color: Palette.muted), onPressed: () => Navigator.pop(context)),
              ]),
            ),
            const Divider(height: 1, color: Palette.outline),
            Expanded(child: ListView(
              controller: scroll,
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
              children: [
                Row(children: [
                  const Icon(Icons.fingerprint_rounded, size: 16, color: Palette.purple),
                  const SizedBox(width: 7),
                  Expanded(child: Text('Your Travel DNA: ${store.topTravelInterest.label} · ${store.wishedCount} dream places · €${store.budget} budget',
                    style: const TextStyle(color: Palette.muted, fontSize: 11))),
                ]),
                const SizedBox(height: 18),
                ...messages.map((m) => Align(
                  alignment: m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: m.fromUser ? Palette.mint.withOpacity(.16) : Palette.surface,
                      border: Border.all(color: m.fromUser ? Palette.mint.withOpacity(.3) : Palette.outline),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(m.body, style: const TextStyle(color: Palette.white, height: 1.45, fontSize: 12.5)),
                  ),
                )),
                if (showMatches && matches.isNotEmpty) ...[
                  const Padding(padding: EdgeInsets.only(bottom: 9), child: Text('CURATED FOR YOU', style: TextStyle(color: Palette.mint, fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 10))),
                  ...matches.take(2).map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () { Navigator.pop(context); widget.onSeeMatches(); store.generate(); },
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Palette.raised, borderRadius: BorderRadius.circular(17), border: Border.all(color: Palette.outline)),
                        child: Row(children: [
                          Text(p.place.flag, style: const TextStyle(fontSize: 25)),
                          const SizedBox(width: 11),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('${p.place.city}, ${p.place.country}', style: const TextStyle(color: Palette.white, fontWeight: FontWeight.w700, fontSize: 13)),
                            const SizedBox(height: 3),
                            Text(p.why, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Palette.muted, fontSize: 10)),
                          ])),
                          Column(children: [Text('${p.match}%', style: const TextStyle(color: Palette.mint, fontSize: 18, fontWeight: FontWeight.w800)), const Text('mock match', style: TextStyle(color: Palette.muted, fontSize: 9))]),
                        ]),
                      ),
                    ),
                  )),
                ],
                const SizedBox(height: 7),
                const Text('EXPLORE AN IDEA', style: TextStyle(color: Palette.muted, letterSpacing: 1, fontWeight: FontWeight.w700, fontSize: 10)),
                const SizedBox(height: 9),
                Wrap(spacing: 7, runSpacing: 4, children: [
                  _chip('Surprise me', Icons.shuffle_rounded, () => _talk('Surprise me!', 'Based on your Travel DNA and saved places, here are two destinations to explore. Tap one to see your full ranked trip feed.', matches: true)),
                  _chip('Nature & adventure', Icons.terrain_rounded, () => _talk('I want an adventure', 'Adventure mode on. I’ve updated your travel style and refreshed your personalized destination matches.', action: () => store.setVibe(TravelVibe.adventure), matches: true)),
                  _chip('Culture & cities', Icons.museum_outlined, () => _talk('Show cultural city breaks', 'Culture it is! I’ve updated your preferred style. Here are some matching ideas.', action: () => store.setVibe(TravelVibe.culture), matches: true)),
                  _chip('Beach escape', Icons.beach_access_rounded, () => _talk('I need a beach escape', 'Relax mode selected. These destinations are now ranked using your updated travel vibe.', action: () => store.setVibe(TravelVibe.relaxing), matches: true)),
                  _chip('Under €800', Icons.wallet_outlined, () => _talk('Trips under €800', 'Done — I’ve set your trip budget to €800 per person. These are the closest matches from our demo destinations.', action: () => store.setBudget(800), matches: true)),
                  _chip('My travel DNA', Icons.fingerprint_rounded, () => _talk('What do you know about me?', 'Your strongest inferred interest is ${store.topTravelInterest.label}. You have ${store.visitedCount} visited countries and ${store.wishedCount} wishlist countries. This influences your trip ranking.')),
                ]),
              ],
            )),
            const Divider(height: 1, color: Palette.outline),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 11, 14, 14),
              child: Row(children: [
                Expanded(child: TextField(
                  controller: input,
                  style: const TextStyle(color: Palette.white, fontSize: 13),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleText(),
                  decoration: InputDecoration(
                    hintText: 'Ask about your next escape...',
                    hintStyle: const TextStyle(color: Palette.muted, fontSize: 12),
                    filled: true, fillColor: Palette.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Palette.outline)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Palette.outline)),
                  ),
                )),
                const SizedBox(width: 9),
                IconButton.filled(onPressed: _handleText, style: IconButton.styleFrom(backgroundColor: Palette.mint, foregroundColor: Palette.bg), icon: const Icon(Icons.arrow_upward_rounded)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
