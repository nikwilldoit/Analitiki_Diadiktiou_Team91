part of 'main.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});
  @override
  State<CommunityScreen> createState()=>_CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String filter='All';
  @override
  Widget build(BuildContext context){
    final store=RoamScope.of(context);
    final all=[...store.customPosts,...DemoData.posts];
    final posts=all.where((p)=>filter=='All'||p.tag==filter).toList();
    return PageFrame(children:[
      SectionHeading(label:'STORIES FROM THE ROAD',title:'Travel better, together.',subtitle:'Real experiences, useful tips and inspiration from fellow explorers.',trailing:IconButton.filledTonal(onPressed:()=>_compose(context),tooltip:'Share a story',icon:const Icon(Icons.edit_rounded,color:Palette.mint))),
      const SizedBox(height:19),
      Container(
        padding:const EdgeInsets.all(18),
        decoration:BoxDecoration(borderRadius:BorderRadius.circular(25),gradient:const LinearGradient(colors:[Color(0xFF3E2D4B),Color(0xFF1B3B45)])),
        child:Row(children:[
          const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text('COLLECT EXPERIENCES',style:TextStyle(color:Palette.orange,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.2)),
            SizedBox(height:8),
            Text('Good trips deserve\ngreat stories.',style:TextStyle(color:Palette.white,fontSize:22,fontWeight:FontWeight.w900,height:1.16)),
            SizedBox(height:8),
            Text('Ask, share, and learn from travellers who have been there.',style:TextStyle(color:Palette.muted,fontSize:11.5)),
          ])),
          const Icon(Icons.forum_rounded,color:Palette.purple,size:74),
        ]),
      ),
      const SizedBox(height:20),
      SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:['All','Budget tips','Travel story','Hidden gems','Itineraries'].map((v)=>Padding(padding:const EdgeInsets.only(right:8),child:Pill(text:v,color:Palette.purple,selected:filter==v,onTap:()=>setState(()=>filter=v)))).toList())),
      const SizedBox(height:16),
      Row(children:[Expanded(child:Text('Community feed',style:Theme.of(context).textTheme.titleLarge)),Text('${posts.length} stories',style:const TextStyle(color:Palette.muted,fontSize:11))]),
      const SizedBox(height:12),
      if(posts.isEmpty) const GlassCard(child:Text('No stories in this category yet. Share yours!',style:TextStyle(color:Palette.muted))),
      ...posts.map((p)=>Padding(padding:const EdgeInsets.only(bottom:12),child:_PostCard(post:p))),
      const SizedBox(height:10),
      ActionButton(text:'Share your travel story',icon:Icons.edit_note_rounded,onTap:()=>_compose(context)),
      const SizedBox(height:11),
      const Center(child:Text('DEMO COMMUNITY • ALL POSTS ARE LOCAL MOCK DATA',style:TextStyle(color:Palette.muted,fontSize:9))),
    ]);
  }
  void _compose(BuildContext context)=>showModalBottomSheet<void>(context:context,isScrollControlled:true,backgroundColor:Palette.surface,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(26))),builder:(ctx)=>const _PostComposer());
}

class _PostCard extends StatelessWidget {
  final TravelPost post;
  const _PostCard({required this.post});
  @override
  Widget build(BuildContext context){
    final store=RoamScope.of(context);
    final liked=store.likes.contains(post.id);
    return GlassCard(onTap:()=>_openStory(context,post),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[
        CircleAvatar(radius:19,backgroundColor:post.color.withOpacity(.20),child:Text(post.initials,style:TextStyle(color:post.color,fontWeight:FontWeight.w900,fontSize:11))),
        const SizedBox(width:10),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(post.name,style:const TextStyle(color:Palette.white,fontSize:12,fontWeight:FontWeight.w900)),const SizedBox(height:3),Text('${post.city} · ${post.when}',style:const TextStyle(color:Palette.muted,fontSize:10.5))])),
        const Icon(Icons.more_horiz_rounded,color:Palette.muted),
      ]),
      const SizedBox(height:13),
      Text(post.title,style:const TextStyle(color:Palette.white,fontWeight:FontWeight.w900,fontSize:17,letterSpacing:-.3)),
      const SizedBox(height:7),
      Text(post.body,maxLines:3,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Palette.muted,height:1.5,fontSize:11.7)),
      const SizedBox(height:12),
      Row(children:[
        Pill(text:post.tag,color:Palette.purple,selected:true),
        const Spacer(),
        IconButton(onPressed:()=>store.toggleLike(post.id),icon:Icon(liked?Icons.favorite_rounded:Icons.favorite_border_rounded,color:liked?Palette.pink:Palette.muted,size:19),tooltip:'Helpful'),
        Text('${post.likes+(liked?1:0)}',style:const TextStyle(color:Palette.muted,fontSize:11)),
        const SizedBox(width:8),
        const Icon(Icons.chat_bubble_outline_rounded,color:Palette.muted,size:17),
        const SizedBox(width:6),
        const Text('Read',style:TextStyle(color:Palette.muted,fontSize:11)),
      ]),
    ]));
  }
}

void _openStory(BuildContext context,TravelPost post){
  showModalBottomSheet<void>(context:context,isScrollControlled:true,backgroundColor:Palette.surface,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(27))),builder:(ctx){
    final store=RoamScope.of(ctx);
    final liked=store.likes.contains(post.id);
    return FractionallySizedBox(heightFactor:.73,child:SafeArea(top:false,child:ListView(padding:const EdgeInsets.all(22),children:[
      const SizedBox(height:4),
      Pill(text:post.tag,color:Palette.purple,selected:true),
      const SizedBox(height:18),
      Text(post.title,style:Theme.of(ctx).textTheme.headlineMedium),
      const SizedBox(height:8),
      Text('${post.name} · ${post.city} · ${post.when}',style:const TextStyle(color:Palette.muted,fontSize:11)),
      const MiniDivider(),
      Text(post.body,style:const TextStyle(color:Palette.white,fontSize:15,height:1.65)),
      const SizedBox(height:22),
      ActionButton(text:liked?'Marked helpful ✓':'Mark this story helpful',icon:liked?Icons.favorite_rounded:Icons.favorite_border_rounded,onTap:()=>store.toggleLike(post.id),filled:!liked),
      const SizedBox(height:23),
      const Text('COMMUNITY CONVERSATION',style:TextStyle(color:Palette.mint,fontWeight:FontWeight.w900,fontSize:10,letterSpacing:1.2)),
      const SizedBox(height:10),
      const GlassCard(color:Palette.raised,child:Row(children:[Icon(Icons.forum_outlined,color:Palette.purple),SizedBox(width:12),Expanded(child:Text('Comments and verified traveller discussions will be added in a future version.',style:TextStyle(color:Palette.muted,fontSize:12,height:1.45)))])),
    ])));
  });
}

class _PostComposer extends StatefulWidget {
  const _PostComposer();
  @override
  State<_PostComposer> createState()=>_PostComposerState();
}
class _PostComposerState extends State<_PostComposer>{
  String title='';
  String body='';
  String city='';
  String tag='Travel story';
  @override
  Widget build(BuildContext context){
    final store=RoamScope.of(context);
    return Padding(padding:EdgeInsets.fromLTRB(19,20,19,math.max(20.0,MediaQuery.viewInsetsOf(context).bottom+16)),child:SingleChildScrollView(child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[
      Text('Share a travel story',style:Theme.of(context).textTheme.titleLarge),
      const SizedBox(height:6),
      const Text('A clickable prototype: your post appears in this session only.',style:TextStyle(color:Palette.muted,fontSize:11)),
      const SizedBox(height:17),
      _input('Title',onChanged:(v)=>title=v),
      const SizedBox(height:10),
      _input('Destination (e.g. Rome, Italy)',onChanged:(v)=>city=v),
      const SizedBox(height:10),
      TextField(maxLines:4,onChanged:(v)=>body=v,style:const TextStyle(color:Palette.white),decoration:_inputStyle('What would you tell another traveller?')),
      const SizedBox(height:14),
      Wrap(spacing:8,runSpacing:8,children:['Travel story','Budget tips','Hidden gems','Itineraries'].map((v)=>Pill(text:v,color:Palette.purple,selected:tag==v,onTap:()=>setState(()=>tag=v))).toList()),
      const SizedBox(height:19),
      ActionButton(text:'Publish mock story',icon:Icons.send_rounded,onTap:(){
        if(title.trim().isEmpty||body.trim().isEmpty||city.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Fill in all three fields to share your story.')));return;}
        final post=TravelPost(id:'new_${DateTime.now().microsecondsSinceEpoch}',name:'You',initials:'ME',city:city.trim(),title:title.trim(),body:body.trim(),tag:tag,when:'Just now',likes:0,color:Palette.mint);
        store.addPost(post);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Story added to your demo feed.')));
      }),
    ])));
  }
  Widget _input(String hint,{required ValueChanged<String> onChanged})=>TextField(onChanged:onChanged,style:const TextStyle(color:Palette.white),decoration:_inputStyle(hint));
  InputDecoration _inputStyle(String hint)=>InputDecoration(hintText:hint,hintStyle:const TextStyle(color:Palette.muted,fontSize:12),filled:true,fillColor:Palette.raised,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:const BorderSide(color:Palette.outline)),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:const BorderSide(color:Palette.outline)));
}
