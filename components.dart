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
