part of 'main.dart';

class PassportScreen extends StatefulWidget {
  final VoidCallback onOpenPlanner;
  const PassportScreen({super.key, required this.onOpenPlanner});
  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  Stamp filter = Stamp.visited;
  bool zoomEurope = false;
  @override
  Widget build(BuildContext context) {
    final store = RoamScope.of(context);
    final filtered = DemoData.places.where((p)=>store.status(p.id)==filter).toList();
    final badge = store.visitedCount >= 12 ? 'WORLD EXPLORER' : store.visitedCount >= 5 ? 'TRAILBLAZER' : 'CURIOUS ROAMER';
    return PageFrame(children:[
      Row(children:[
        const Icon(Icons.blur_on_rounded,color:Palette.mint,size:26),
        const SizedBox(width:8),
        const Text('ROAM',style:TextStyle(fontSize:19,fontWeight:FontWeight.w900,letterSpacing:3,color:Palette.white)),
        const Spacer(),
        IconButton.filledTonal(onPressed:()=>_openIdentity(context),tooltip:'My travel identity',icon:const Icon(Icons.person_outline_rounded,color:Palette.mint)),
      ]),
      const SizedBox(height:18),
      const SectionHeading(label:'YOUR TRAVEL PASSPORT',title:'The world is yours.',subtitle:'Every place becomes part of your story. Tap a marker to colour your map.'),
      const SizedBox(height:19),
      Container(
        padding:const EdgeInsets.fromLTRB(14,16,14,12),
        decoration:BoxDecoration(
          gradient:const LinearGradient(colors:[Color(0xFF1A3B45),Color(0xFF142839),Color(0xFF191E3B)],begin:Alignment.topLeft,end:Alignment.bottomRight),
          border:Border.all(color:const Color(0xFF345962)),
          borderRadius:BorderRadius.circular(27),
        ),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(children:[
            const Icon(Icons.public_rounded,color:Palette.mint,size:18),
            const SizedBox(width:7),
            const Text('MY WORLD MAP',style:TextStyle(fontSize:11,fontWeight:FontWeight.w900,letterSpacing:1.3)),
            const Spacer(),
            Text('${store.visitedCount} explored',style:const TextStyle(fontSize:11,color:Palette.mint,fontWeight:FontWeight.w800)),
          ]),
          const SizedBox(height:9),
          Row(children:[
            Pill(text:'World',color:Palette.mint,selected:!zoomEurope,onTap:()=>setState(()=>zoomEurope=false)),
            const SizedBox(width:7),
            Pill(text:'Europe zoom',color:Palette.mint,selected:zoomEurope,onTap:()=>setState(()=>zoomEurope=true)),
            const Spacer(),
            const Icon(Icons.touch_app_outlined,color:Palette.muted,size:16),
          ]),
          const SizedBox(height:8),
          AspectRatio(aspectRatio:1.55,child:LayoutBuilder(builder:(context,box)=>GestureDetector(
            behavior:HitTestBehavior.opaque,
            onTapDown:(d){
              Destination? closest;
              var distance=double.infinity;
              for(final p in DemoData.places){
                final pt=WorldMapPainter.project(p.lon,p.lat,Size(box.maxWidth,box.maxHeight),zoomEurope);
                final dx=pt.dx-d.localPosition.dx,dy=pt.dy-d.localPosition.dy;
                final dist=math.sqrt(dx*dx+dy*dy);
                if(dist<distance){distance=dist;closest=p;}
              }
              if(closest!=null && distance<23) openPlace(context,closest);
            },
            child:CustomPaint(size:Size(box.maxWidth,box.maxHeight),painter:WorldMapPainter(Map<String,Stamp>.of(store.stamps),zoomEurope)),
          ))),
          const SizedBox(height:7),
          const Wrap(spacing:13,runSpacing:7,children:[
            MapLegend('Visited',Palette.mint),
            MapLegend('Wishlist',Palette.purple),
            MapLegend('Planned',Palette.orange),
          ]),
          const SizedBox(height:6),
          const Text('Stylized interactive map · Tap coloured dots',style:TextStyle(color:Color(0xFF8EB8C0),fontSize:10)),
        ]),
      ),
      const SizedBox(height:15),
      Row(children:[
        StatBox(number:'${store.visitedCount}',label:'Countries',color:Palette.mint),
        const SizedBox(width:9),
        StatBox(number:'${store.continentsVisited}',label:'Continents',color:Palette.purple),
        const SizedBox(width:9),
        StatBox(number:'${store.wishedCount}',label:'Dream stops',color:Palette.orange),
      ]),
      const SizedBox(height:17),
      GlassCard(onTap:()=>_openIdentity(context),color:const Color(0xFF1D2940),child:Row(children:[
        Container(width:45,height:45,decoration:BoxDecoration(color:Palette.orange.withOpacity(.15),borderRadius:BorderRadius.circular(15)),child:const Icon(Icons.workspace_premium_rounded,color:Palette.orange,size:25)),
        const SizedBox(width:12),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(badge,style:const TextStyle(fontSize:12,color:Palette.orange,fontWeight:FontWeight.w900,letterSpacing:.6)),
          const SizedBox(height:4),
          const Text('Your explorer rank • Tap to view badges',style:TextStyle(color:Palette.muted,fontSize:11)),
        ])),
        const Icon(Icons.chevron_right,color:Palette.muted),
      ])),
      const SizedBox(height:24),
      Row(children:[
        Expanded(child:Text('Your places',style:Theme.of(context).textTheme.titleLarge)),
        Text('${filtered.length} places',style:const TextStyle(color:Palette.muted,fontSize:11)),
      ]),
      const SizedBox(height:12),
      Wrap(spacing:8,runSpacing:8,children:[
        Pill(text:'Visited',color:Palette.mint,selected:filter==Stamp.visited,onTap:()=>setState(()=>filter=Stamp.visited)),
        Pill(text:'Wishlist',color:Palette.purple,selected:filter==Stamp.wishlist,onTap:()=>setState(()=>filter=Stamp.wishlist)),
        Pill(text:'Planned',color:Palette.orange,selected:filter==Stamp.planned,onTap:()=>setState(()=>filter=Stamp.planned)),
      ]),
      const SizedBox(height:12),
      if(filtered.isEmpty) GlassCard(child:Column(children:[
        const Icon(Icons.travel_explore_rounded,color:Palette.muted,size:30),
        const SizedBox(height:9),
        const Text('Nothing here yet',style:TextStyle(color:Palette.white,fontWeight:FontWeight.w800)),
        const SizedBox(height:5),
        const Text('Explore destinations and add them to your map.',style:TextStyle(color:Palette.muted,fontSize:11)),
      ])),
      ...filtered.map((p)=>Padding(padding:const EdgeInsets.only(bottom:9),child:PlaceCard(place:p))),
      const SizedBox(height:15),
      Container(padding:const EdgeInsets.all(19),decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[Color(0xFF263E50),Color(0xFF263451)])),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Icon(Icons.auto_awesome_rounded,color:Palette.mint),
        const SizedBox(height:10),
        const Text('Where will your story go next?',style:TextStyle(color:Palette.white,fontSize:18,fontWeight:FontWeight.w900)),
        const SizedBox(height:5),
        const Text('Turn your dream list into a personalised trip idea.',style:TextStyle(color:Palette.muted,fontSize:12)),
        const SizedBox(height:15),
        ActionButton(text:'Find my next adventure',icon:Icons.arrow_forward_rounded,onTap:widget.onOpenPlanner),
      ])),
    ]);
  }

  void _openIdentity(BuildContext context){
    showModalBottomSheet<void>(context:context,isScrollControlled:true,backgroundColor:Palette.surface,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(27))),builder:(sheetContext){
      final store=RoamScope.of(sheetContext);
      return SafeArea(top:false,child:SingleChildScrollView(padding:const EdgeInsets.all(24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
        const SizedBox(height:9),
        const Row(children:[CircleAvatar(radius:28,backgroundColor:Palette.raised,child:Icon(Icons.person_rounded,color:Palette.mint,size:29)),SizedBox(width:14),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('My travel identity',style:TextStyle(color:Palette.white,fontSize:22,fontWeight:FontWeight.w900)),SizedBox(height:3),Text('Your world, your milestones',style:TextStyle(color:Palette.muted,fontSize:12))]))]),
        const SizedBox(height:22),
        Row(children:[StatBox(number:'${store.visitedCount}',label:'Visited',color:Palette.mint),const SizedBox(width:8),StatBox(number:'${store.wishedCount}',label:'Dream list',color:Palette.purple)]),
        const SizedBox(height:18),
        const Text('YOUR ACHIEVEMENTS',style:TextStyle(color:Palette.mint,fontWeight:FontWeight.w900,fontSize:10,letterSpacing:1.5)),
        const SizedBox(height:12),
        _achievement('First stamp','Visit your first country',Icons.flag_rounded,store.visitedCount>=1),
        _achievement('Trailblazer','Explore 5 countries',Icons.explore_rounded,store.visitedCount>=5),
        _achievement('Around the world','Visit 3 continents',Icons.public_rounded,store.continentsVisited>=3),
        _achievement('Dream collector','Save 5 dream destinations',Icons.auto_awesome_rounded,store.wishedCount>=5),
        const SizedBox(height:16),
        const Text('YOUR TRAVEL STYLE',style:TextStyle(color:Palette.mint,fontWeight:FontWeight.w900,fontSize:10,letterSpacing:1.5)),
        const SizedBox(height:10),
        Wrap(spacing:8,runSpacing:8,children:TravelVibe.values.map((v)=>Pill(text:v.label,icon:v.icon,color:Palette.purple,selected:store.vibe==v,onTap:()=>store.setVibe(v))).toList()),
        const SizedBox(height:11),
        const Text('Your style also influences the mock trip recommendations.',style:TextStyle(color:Palette.muted,fontSize:11)),
      ])));
    });
  }
  Widget _achievement(String title,String subtitle,IconData icon,bool unlocked)=>Padding(padding:const EdgeInsets.only(bottom:9),child:GlassCard(color:Palette.raised,padding:const EdgeInsets.all(12),child:Row(children:[Icon(icon,color:unlocked?Palette.orange:Palette.muted),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:TextStyle(color:unlocked?Palette.white:Palette.muted,fontWeight:FontWeight.w800)),Text(subtitle,style:const TextStyle(color:Palette.muted,fontSize:11))])),Icon(unlocked?Icons.verified_rounded:Icons.lock_outline_rounded,color:unlocked?Palette.mint:Palette.muted,size:18)])));
}

class MapLegend extends StatelessWidget {
  final String text;
  final Color color;
  const MapLegend(this.text,this.color,{super.key});
  @override
  Widget build(BuildContext context)=>Row(mainAxisSize:MainAxisSize.min,children:[Container(width:8,height:8,decoration:BoxDecoration(color:color,shape:BoxShape.circle)),const SizedBox(width:5),Text(text,style:const TextStyle(color:Color(0xFFDCEBE9),fontSize:10,fontWeight:FontWeight.w700))]);
}

class WorldMapPainter extends CustomPainter {
  final Map<String,Stamp> stamps;
  final bool zoomEurope;
  const WorldMapPainter(this.stamps,this.zoomEurope);
  static Offset project(double lon,double lat,Size size,[bool europe=false])=>europe
      ? Offset(((lon+25)/75)*size.width,((72-lat)/48)*size.height)
      : Offset(((lon+180)/360)*size.width,((76-lat)/152)*size.height);
  @override
  void paint(Canvas canvas,Size size){
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    final lines=Paint()..color=const Color(0xFF5A8B97).withOpacity(.12)..strokeWidth=.8;
    for(var n=1;n<8;n++){final x=size.width*n/8;canvas.drawLine(Offset(x,0),Offset(x,size.height),lines);}
    for(var n=1;n<5;n++){final y=size.height*n/5;canvas.drawLine(Offset(0,y),Offset(size.width,y),lines);}
    void land(List<Offset> pts){final path=Path();final first=project(pts.first.dx,pts.first.dy,size,zoomEurope);path.moveTo(first.dx,first.dy);for(final p in pts.skip(1)){final pt=project(p.dx,p.dy,size,zoomEurope);path.lineTo(pt.dx,pt.dy);}path.close();canvas.drawPath(path,Paint()..color=const Color(0xFF315263));canvas.drawPath(path,Paint()..color=const Color(0xFF51788A).withOpacity(.55)..style=PaintingStyle.stroke..strokeWidth=1.0);}
    land(const [Offset(-168,70),Offset(-132,70),Offset(-120,59),Offset(-127,50),Offset(-123,41),Offset(-114,32),Offset(-108,29),Offset(-98,18),Offset(-87,18),Offset(-82,10),Offset(-78,10),Offset(-79,24),Offset(-66,45),Offset(-57,52),Offset(-68,61),Offset(-84,59),Offset(-97,69),Offset(-130,74)]);
    land(const [Offset(-82,12),Offset(-74,9),Offset(-67,8),Offset(-51,4),Offset(-40,-4),Offset(-37,-15),Offset(-46,-24),Offset(-52,-34),Offset(-70,-56),Offset(-75,-39),Offset(-81,-12)]);
    land(const [Offset(-53,59),Offset(-47,61),Offset(-42,72),Offset(-48,83),Offset(-58,81),Offset(-62,66)]);
    land(const [Offset(-25,63),Offset(-14,67),Offset(-13,64),Offset(-21,63)]);
    land(const [Offset(-10,36),Offset(-10,48),Offset(-5,50),Offset(-9,56),Offset(-4,58),Offset(5,54),Offset(14,55),Offset(23,60),Offset(32,70),Offset(45,70),Offset(58,61),Offset(76,55),Offset(88,56),Offset(101,53),Offset(118,52),Offset(133,44),Offset(143,45),Offset(151,59),Offset(168,61),Offset(174,52),Offset(147,34),Offset(125,22),Offset(117,9),Offset(105,1),Offset(99,6),Offset(92,22),Offset(80,7),Offset(76,10),Offset(70,22),Offset(54,27),Offset(44,38),Offset(31,36),Offset(25,41),Offset(16,42),Offset(10,37),Offset(2,36)]);
    land(const [Offset(-16,37),Offset(9,37),Offset(16,29),Offset(27,30),Offset(35,20),Offset(42,12),Offset(51,10),Offset(43,-12),Offset(33,-23),Offset(20,-35),Offset(17,-35),Offset(12,-22),Offset(6,-5),Offset(-4,5),Offset(-15,18)]);
    land(const [Offset(112,-11),Offset(130,-12),Offset(137,-17),Offset(153,-24),Offset(152,-37),Offset(142,-39),Offset(129,-34),Offset(115,-22)]);
    land(const [Offset(130,31),Offset(141,42),Offset(146,43),Offset(145,34),Offset(138,32)]);
    land(const [Offset(48,-13),Offset(50,-24),Offset(45,-26),Offset(43,-17)]);
    // Colour-coded country markers. This is a deliberately stylized map, not political border geometry.
    for(final p in DemoData.places){
      final stamp=stamps[p.id]??Stamp.none;
      final c=stampColor(stamp);
      final point=project(p.lon,p.lat,size,zoomEurope);
      if(stamp!=Stamp.none){
        canvas.drawCircle(point,10,Paint()..color=c.withOpacity(.18));
        canvas.drawCircle(point,5.5,Paint()..color=c);
        canvas.drawCircle(point,2,Paint()..color=const Color(0xFF0B1724));
      }else{
        canvas.drawCircle(point,2.6,Paint()..color=const Color(0xFFABC1C7).withOpacity(.65));
      }
    }
    final textPainter=TextPainter(text:const TextSpan(text:'EUROPE',style:TextStyle(color:Color(0xFFAAC5CE),fontSize:8,fontWeight:FontWeight.bold,letterSpacing:1)),textDirection:TextDirection.ltr)..layout();
    textPainter.paint(canvas,project(8,57,size,zoomEurope));
    canvas.restore();
  }
  @override
  bool shouldRepaint(covariant WorldMapPainter old)=>!_sameMap(old.stamps,stamps) || old.zoomEurope != zoomEurope;
  bool _sameMap(Map<String,Stamp> a,Map<String,Stamp> b){ if(a.length!=b.length)return false; for(final key in a.keys){if(a[key]!=b[key])return false;}return true; }
}
