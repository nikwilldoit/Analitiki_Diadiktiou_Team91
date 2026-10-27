part of 'main.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store=RoamScope.of(context);
    return PageFrame(children:[
      Row(children:[
        Expanded(child:SectionHeading(label:'YOUR PERSONAL TRAVEL ENGINE',title:store.generated?'Your next chapter.':'Dream it. Plan it.',subtitle:store.generated?'Illustrative destinations ranked by your choices and dream list.':'Tell ROAM what matters to you. Get trip ideas tailored to your budget and travel style.')),
        if(store.generated) IconButton.filledTonal(onPressed:store.editTrip,tooltip:'Edit trip',icon:const Icon(Icons.tune_rounded,color:Palette.mint)),
      ]),
      const SizedBox(height:19),
      if(!store.generated) ...[
        const _TripIntroCard(),
        const SizedBox(height:20),
        GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(children:[const Icon(Icons.account_balance_wallet_outlined,color:Palette.mint),const SizedBox(width:9),const Text('Budget per person',style:TextStyle(color:Palette.white,fontWeight:FontWeight.w900)),const Spacer(),Text('€${store.budget}',style:const TextStyle(color:Palette.mint,fontSize:20,fontWeight:FontWeight.w900))]),
          const SizedBox(height:12),
          Slider(value:store.budget.toDouble(),min:300,max:3500,divisions:32,activeColor:Palette.mint,inactiveColor:Palette.outline,label:'€${store.budget}',onChanged:store.setBudget),
          const Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text('€300',style:TextStyle(color:Palette.muted,fontSize:10)),Text('€3,500',style:TextStyle(color:Palette.muted,fontSize:10))]),
          const SizedBox(height:12),
          const Text('Estimates include an illustrative return flight and daily spending.',style:TextStyle(color:Palette.muted,fontSize:11,height:1.4)),
        ])),
        const SizedBox(height:12),
        GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const _FieldLabel('WHO IS COMING?',Icons.people_alt_outlined),
          const SizedBox(height:11),
          Wrap(spacing:8,runSpacing:8,children:['Solo','Couple','Friends','Family'].map((v)=>Pill(text:v,color:Palette.purple,selected:store.companions==v,onTap:()=>store.setCompanions(v))).toList()),
          const MiniDivider(),
          const _FieldLabel('WHERE WOULD YOU GO?',Icons.public_rounded),
          const SizedBox(height:11),
          Wrap(spacing:8,runSpacing:8,children:['Anywhere','Europe','Asia','Americas','Africa'].map((r)=>Pill(text:r,color:Palette.mint,selected:store.region==r,onTap:()=>store.setRegion(r))).toList()),
          const MiniDivider(),
          const _FieldLabel('WHAT IS YOUR VIBE?',Icons.auto_awesome_rounded),
          const SizedBox(height:11),
          Wrap(spacing:8,runSpacing:8,children:TravelVibe.values.map((v)=>Pill(text:v.label,icon:v.icon,color:Palette.orange,selected:store.vibe==v,onTap:()=>store.setVibe(v))).toList()),
          const MiniDivider(),
          const _FieldLabel('WHEN ARE YOU THINKING?',Icons.calendar_month_rounded),
          const SizedBox(height:11),
          Wrap(spacing:8,runSpacing:8,children:['Anytime','Spring','Summer','Autumn','Winter'].map((v)=>Pill(text:v,color:Palette.purple,selected:store.season==v,onTap:()=>store.setSeason(v))).toList()),
        ])),
        const SizedBox(height:13),
        GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(children:[const Icon(Icons.timelapse_rounded,color:Palette.mint),const SizedBox(width:10),const Text('How many days?',style:TextStyle(color:Palette.white,fontWeight:FontWeight.w900)),const Spacer(),Text('${store.days} days',style:const TextStyle(color:Palette.mint,fontWeight:FontWeight.w900,fontSize:17))]),
          const SizedBox(height:8),
          Slider(value:store.days.toDouble(),min:3,max:14,divisions:11,label:'${store.days} days',activeColor:Palette.mint,inactiveColor:Palette.outline,onChanged:store.setDays),
        ])),
        const SizedBox(height:18),
        ActionButton(text:'Find my perfect trip',icon:Icons.auto_awesome_rounded,onTap:store.generate),
        const SizedBox(height:13),
        const Center(child:Text('DEMO RECOMMENDER • NO LIVE FLIGHTS OR BOOKINGS',style:TextStyle(color:Palette.muted,fontSize:9,letterSpacing:.5))),
      ] else ...[
        _ResultsSummary(store:store),
        const SizedBox(height:20),
        Row(children:[const Icon(Icons.stars_rounded,color:Palette.orange),const SizedBox(width:8),Expanded(child:Text('Your top matches',style:Theme.of(context).textTheme.titleLarge))]),
        const SizedBox(height:13),
        ...store.recommendations.asMap().entries.map((entry){
          final i=entry.key;
          final p=entry.value;
          return Padding(padding:const EdgeInsets.only(bottom:13),child:_TripResultCard(result:p,featured:i==0));
        }),
        const SizedBox(height:7),
        const GlassCard(child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(Icons.info_outline_rounded,color:Palette.blue),SizedBox(width:11),Expanded(child:Text('Prototype only: match scores and costs are illustrative estimates based on mock data, not trained AI or live availability. Season and group preference also add small mock ranking boosts; future versions can use validated seasonal data and group-specific prices.',style:TextStyle(color:Palette.muted,fontSize:11.5,height:1.5)))])),
        const SizedBox(height:13),
        ActionButton(text:'Adjust my preferences',icon:Icons.tune_rounded,onTap:store.editTrip,filled:false),
      ],
    ]);
  }
}

class _TripIntroCard extends StatelessWidget {
  const _TripIntroCard();
  @override
  Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.all(18),
    decoration:BoxDecoration(borderRadius:BorderRadius.circular(24),gradient:const LinearGradient(colors:[Color(0xFF244653),Color(0xFF203048),Color(0xFF332A50)])),
    child:Row(children:[
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('ROAM MATCH ENGINE',style:TextStyle(color:Palette.mint,fontSize:10,letterSpacing:1.3,fontWeight:FontWeight.w900)),
        const SizedBox(height:11),
        const Text('Less searching.\nMore exploring.',style:TextStyle(color:Palette.white,fontSize:24,height:1.15,letterSpacing:-.65,fontWeight:FontWeight.w900)),
        const SizedBox(height:10),
        const Text('Your budget + your vibe + your passport = a smarter shortlist.',style:TextStyle(color:Color(0xFFC4D6DD),fontSize:11.5,height:1.5)),
      ])),
      const SizedBox(width:5),
      const Icon(Icons.travel_explore_rounded,color:Palette.mint,size:91),
    ]),
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  const _FieldLabel(this.text,this.icon);
  @override
  Widget build(BuildContext context)=>Row(children:[Icon(icon,color:Palette.mint,size:18),const SizedBox(width:8),Text(text,style:const TextStyle(color:Palette.white,fontWeight:FontWeight.w900,fontSize:11,letterSpacing:.9))]);
}

class _ResultsSummary extends StatelessWidget {
  final RoamStore store;
  const _ResultsSummary({required this.store});
  @override
  Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.all(17),
    decoration:BoxDecoration(borderRadius:BorderRadius.circular(24),gradient:const LinearGradient(colors:[Color(0xFF1C4851),Color(0xFF1A2C48)])),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Row(children:[Icon(Icons.auto_awesome_rounded,color:Palette.mint,size:18),SizedBox(width:7),Text('YOUR TRAVEL BLUEPRINT',style:TextStyle(color:Palette.mint,fontSize:10,letterSpacing:1,fontWeight:FontWeight.w900))]),
      const SizedBox(height:10),
      Text('€${store.budget} · ${store.days} days · ${store.companions}',style:const TextStyle(color:Palette.white,fontSize:19,fontWeight:FontWeight.w900)),
      const SizedBox(height:9),
      Wrap(spacing:8,runSpacing:7,children:[Pill(text:store.region,selected:true),Pill(text:store.vibe.label,color:Palette.orange,selected:true),Pill(text:store.season,color:Palette.purple,selected:true)]),
      const SizedBox(height:11),
      const Text('Estimated prices per person • Assumed departure: Athens',style:TextStyle(color:Palette.muted,fontSize:10.5)),
    ]),
  );
}

class _TripResultCard extends StatelessWidget {
  final TripPick result;
  final bool featured;
  const _TripResultCard({required this.result,required this.featured});
  @override
  Widget build(BuildContext context){
    final p=result.place;
    final store=RoamScope.of(context);
    return GlassCard(padding:const EdgeInsets.all(12),color:featured?const Color(0xFF1C2D3E):Palette.surface,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      if(featured) ...[const Padding(padding:EdgeInsets.only(left:4,bottom:10),child:Row(children:[Icon(Icons.verified_rounded,color:Palette.mint,size:15),SizedBox(width:6),Text('BEST MATCH FOR YOU',style:TextStyle(color:Palette.mint,fontSize:10,letterSpacing:1.1,fontWeight:FontWeight.w900))])),],
      GestureDetector(onTap:()=>openPlace(context,p),child:LandscapeArt(place:p,height:featured?176:129)),
      const SizedBox(height:13),
      Row(children:[Expanded(child:Text('${p.flag} ${p.city}',style:const TextStyle(color:Palette.white,fontSize:19,fontWeight:FontWeight.w900))),Container(padding:const EdgeInsets.symmetric(horizontal:9,vertical:6),decoration:BoxDecoration(color:Palette.mint.withOpacity(.12),borderRadius:BorderRadius.circular(10)),child:Text('${result.match}% match',style:const TextStyle(color:Palette.mint,fontSize:11,fontWeight:FontWeight.w900)))]),
      const SizedBox(height:4),
      Text(result.why,style:const TextStyle(color:Palette.muted,fontSize:11.5)),
      const SizedBox(height:12),
      Row(children:[const Text('EST. TOTAL',style:TextStyle(color:Palette.muted,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:.7)),const SizedBox(width:9),Text('€${result.estimate}',style:const TextStyle(color:Palette.white,fontSize:19,fontWeight:FontWeight.w900)),const Text(' / person',style:TextStyle(color:Palette.muted,fontSize:10)),const Spacer(),IconButton(onPressed:()=>store.setStamp(p.id,store.status(p.id)==Stamp.wishlist?Stamp.none:Stamp.wishlist),tooltip:'Toggle dream list',icon:Icon(store.status(p.id)==Stamp.wishlist?Icons.favorite_rounded:Icons.favorite_outline_rounded,color:Palette.purple)),IconButton(onPressed:()=>openPlace(context,p),tooltip:'View details',icon:const Icon(Icons.arrow_forward_rounded,color:Palette.mint))]),
    ]));
  }
}
