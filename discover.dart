part of 'main.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String query = '';
  String region = 'All';
  bool dreamOnly = false;

  @override
  Widget build(BuildContext context) {
    final store=RoamScope.of(context);
    final list=DemoData.places.where((p){
      final matches=p.city.toLowerCase().contains(query.toLowerCase()) || p.country.toLowerCase().contains(query.toLowerCase()) || p.highlight.toLowerCase().contains(query.toLowerCase());
      return matches && (region=='All'||p.region==region) && (!dreamOnly||store.status(p.id)==Stamp.wishlist);
    }).toList();
    return PageFrame(children:[
      const SectionHeading(label:'CURATED FOR THE CURIOUS',title:'Go somewhere new.',subtitle:'Browse places, discover your next obsession and build a colourful dream list.'),
      const SizedBox(height:20),
      TextField(
        onChanged:(v)=>setState(()=>query=v),
        style:const TextStyle(color:Palette.white,fontSize:13),
        decoration:InputDecoration(
          hintText:'Search cities, countries, vibes...',hintStyle:const TextStyle(color:Palette.muted,fontSize:12),
          prefixIcon:const Icon(Icons.search_rounded,color:Palette.mint),
          filled:true,fillColor:Palette.surface,
          contentPadding:const EdgeInsets.symmetric(vertical:17,horizontal:13),
          border:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:const BorderSide(color:Palette.outline)),
          enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:const BorderSide(color:Palette.outline)),
        ),
      ),
      const SizedBox(height:14),
      SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:['All','Europe','Asia','Americas','Africa'].map((r)=>Padding(padding:const EdgeInsets.only(right:8),child:Pill(text:r,selected:region==r,onTap:()=>setState(()=>region=r)))).toList())),
      const SizedBox(height:14),
      Row(children:[
        const Icon(Icons.favorite_rounded,color:Palette.purple,size:18),
        const SizedBox(width:8),
        const Expanded(child:Text('My dream list only',style:TextStyle(fontSize:12.5,fontWeight:FontWeight.w600))),
        Switch(value:dreamOnly,activeColor:Palette.mint,onChanged:(v)=>setState(()=>dreamOnly=v)),
      ]),
      const SizedBox(height:14),
      if(query.isEmpty && !dreamOnly && region=='All') ...[
        Container(
          padding:const EdgeInsets.all(17),
          decoration:BoxDecoration(borderRadius:BorderRadius.circular(25),gradient:const LinearGradient(colors:[Color(0xFF2D334E),Color(0xFF1D3545)]),border:Border.all(color:const Color(0xFF3A4C61))),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Row(children:[const Icon(Icons.auto_awesome_rounded,color:Palette.orange,size:17),const SizedBox(width:6),const Text('DESTINATION SPOTLIGHT',style:TextStyle(color:Palette.orange,fontWeight:FontWeight.w700,letterSpacing:1.2,fontSize:10)),const Spacer(),const Text('✦ EDITOR’S PICK',style:TextStyle(color:Palette.muted,fontSize:9))]),
            const SizedBox(height:12),
            GestureDetector(onTap:()=>openPlace(context,DemoData.places[6]),child:LandscapeArt(place:DemoData.places[6],height:200)),
            const SizedBox(height:12),
            const Text('Temples, lanterns and quiet mornings',style:TextStyle(color:Palette.white,fontSize:17,fontWeight:FontWeight.w700)),
            const SizedBox(height:6),
            const Text('A fresh favourite for culture seekers and slow travellers.',style:TextStyle(color:Palette.muted,fontSize:12)),
            const SizedBox(height:13),
            Row(children:[Expanded(child:Pill(text:'Explore Kyoto',icon:Icons.arrow_outward_rounded,color:Palette.orange,selected:true,onTap:()=>openPlace(context,DemoData.places[6]))),const Spacer()]),
          ]),
        ),
        const SizedBox(height:23),
      ],
      Row(children:[Expanded(child:Text(dreamOnly?'Your dream destinations':'Explore destinations',style:Theme.of(context).textTheme.titleLarge)),Text('${list.length} places',style:const TextStyle(color:Palette.muted,fontSize:11))]),
      const SizedBox(height:13),
      if(list.isEmpty) const GlassCard(child:Column(children:[Icon(Icons.travel_explore_rounded,size:32,color:Palette.muted),SizedBox(height:9),Text('No destinations found',style:TextStyle(fontWeight:FontWeight.w600)),SizedBox(height:4),Text('Try another region or clear your search.',style:TextStyle(color:Palette.muted,fontSize:11))])),
      ...list.map((p)=>Padding(padding:const EdgeInsets.only(bottom:10),child:PlaceCard(place:p))),
      const SizedBox(height:15),
      GlassCard(color:const Color(0xFF1B2B3F),child:Row(children:[
        const Icon(Icons.lightbulb_rounded,color:Palette.orange,size:27),const SizedBox(width:12),
        const Expanded(child:Text('Tip: Save destinations to your wishlist. The trip planner uses your dreams to personalise recommendations.',style:TextStyle(fontSize:12,color:Palette.white,height:1.45))),
      ])),
    ]);
  }
}
