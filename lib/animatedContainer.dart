import 'package:flutter/material.dart';

import 'defaultText.dart';

void main() {
  runApp((Animated()));
}
class Animated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue[60],
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Animation",),),
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        body:Column(
          children: <Widget>[
            Expanded(child: Slide(),),
            Expanded(child: ItemList(),),
            //Expanded(child: MyDetailPage(),),
          ],
        )

      ),
      );
  }
}
class Slide extends StatefulWidget {
  @override
  _SlideState createState() => _SlideState();
}
class _SlideState extends State<Slide> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        SlideTransition(
        position: _animation,
        child:Center(
          child:Image.asset("assets/1.jpeg",width: 150,height: 150,)
          //FlutterLogo(size: 100,),
        ),
      ),
        // Container(
        //   child: DecoratedBoxTransition(
        //     position: DecorationPosition.background,
        //     decoration: decorationTween.animate(_controller),
        //     child: Container(
        //       width: 100,
        //       height: 100,
        //       padding: EdgeInsets.all(5),
        //       child:Image.asset("assets/1.jpeg") ,
        //     ),
        //   ),
        // ),
    ],);
  }
}
class ItemList extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}
class _ListState extends State<ItemList>{
  final GlobalKey <AnimatedListState> listKey= GlobalKey<AnimatedListState>();
  List<String> _item = [];
  int counter = 0;

  Widget _listItem(BuildContext context,int index,animation) {
  String item = _item[index];
  return SlideTransition(
    position: Tween<Offset>(
      begin: Offset(-1,0),
      end: Offset.zero,
    ).animate(animation),
      child: ListTile(title: Text(item,textAlign: TextAlign.center,),),
  );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            height: double.infinity,
            child: AnimatedList(
              key: listKey,
              initialItemCount: _item.length,
              itemBuilder: (context, index, animation) {
                return _listItem(context, index, animation);
              },
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: (){
                  setState(() {
                    listKey.currentState.insertItem(0, duration: const Duration(milliseconds: 500));
                    _item = []
                      ..add(DateTime.now().toIso8601String())
                      ..addAll(_item);
                  });
                },
                child: Text("Add Text",),),
            FlatButton(
                onPressed: () {
                  if (_item.length <= 1)
                    return;
                  listKey.currentState.removeItem(0, (_,animation) => _listItem(context, 0, animation),
                      duration:Duration(milliseconds: 500),
                  );
                  setState(() {
                    _item.removeAt(0);
                  });
                },
              child: Text("Remove Text",),
            ),
          ],
        ),
      ],
    );
  }
}
// ignore: must_be_immutable
class MyDetailPage extends StatefulWidget {
  MySuperHero _superHero;

  MyDetailPage(MySuperHero superHero) {
    _superHero = superHero;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_superHero);
}

class _MyDetailPageState extends State<MyDetailPage> {
  MySuperHero superHero;

  _MyDetailPageState(MySuperHero superHero) {
    this.superHero = superHero;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                transitionOnUserGestures: true,
                tag: superHero,
                child: Transform.scale(
                  scale: 2.0,
                  child: Image.asset("assets/1.jpeg"),
                ),
              ),
              // Card(
              //     elevation: 8,
              //     margin: EdgeInsets.all(16),
              //     child: Container(
              //       padding: EdgeInsets.all(16),
              //       child: Text(superHero.body),
              //     )
              // ),
            ],
          ));
  }
}