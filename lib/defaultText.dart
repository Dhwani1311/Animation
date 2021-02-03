import 'package:flutter/material.dart';
//import 'package:flutter_animation/amimatedBuilder.dart';
import 'package:flutter_animation/animatedContainer.dart';
void main() {
  runApp((MyHome()));
}
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        backgroundColor: Colors.white,

        body: Column(
            children: <Widget>[
          //     SingleChildScrollView(
          //       child: Column(
          //       children: <Widget>[
          //         AnimatedContain(),
          //         Rotate(),
          //         Scale(),
          // MyHomePage(),
             // ],
             // )
               Expanded(child:AnimatedContain(),),
                Expanded(child:Rotate(),),
                Expanded(child:Scale(),),
               Expanded(child:MyHomePage(),)
               ],
        ),
      ),
    );
  }
}
class AnimatedContain extends StatefulWidget {
  AnimatedContain({Key key}) : super(key: key);

  @override
  _AnimatedState createState() => _AnimatedState();
}
class _AnimatedState extends State<AnimatedContain> with SingleTickerProviderStateMixin {
  int _count = 0;
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(50),
      border: Border.all(style: BorderStyle.none,),
      shape: BoxShape.rectangle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.white,
          blurRadius: 10,
          spreadRadius: 3,
          offset: Offset(0,6),
        )
      ]
    ),
    end: BoxDecoration(
      color: Colors.blue,
      border: Border.all(
      style: BorderStyle.none,),
      borderRadius: BorderRadius.zero,),
    );
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    super.initState();
  }
 @override
 void dispose(){
    animationController.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: Text(
            '$_count',
            key: ValueKey<int>(_count),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: RaisedButton(
              child: const Text('Increment'),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ),
        ),
        Container(
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: decorationTween.animate(animationController),
            child: Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(5),
              child:Image.asset("assets/1.jpeg") ,
            ),
          ),
        ),
        // SizedBox(height: 5,),
        // Container(
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
        //     }, // handle your image tap here
        //     child: Image.asset(
        //       'assets/2.jpeg',
        //       fit: BoxFit.cover, // this is the solution for border
        //       width: 110.0,
        //       height: 110.0,
        //     ),
        //   ),
        // ),
      ],
      ),);
  }
}
class Rotate extends StatefulWidget {
  Rotate({Key key}) : super(key: key);

  @override
  _RotateState createState() => _RotateState();
}
class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
      animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
        body:
          Padding(
            padding: const EdgeInsets.only(top:30,left: 80,),
            child: RotationTransition(
              turns: animation,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/1.jpeg",width: 100,height: 100,),
              ),
            ),
          ),
         );
  }
}
class Scale extends StatefulWidget {
  Scale({Key key}) : super(key: key);
  @override
  _ScaleState createState() => _ScaleState();
}
class _ScaleState extends State<Scale> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: EdgeInsets.only(left: 50),
            child: Image.asset( "assets/2.jpeg",width: 100,height: 100,),
          ),
        ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MySuperHero {
  final String img;
  MySuperHero(this.img);
}

class _MyHomePageState extends State<MyHomePage> {
  List<MySuperHero> items = new List<MySuperHero>();

  _MyHomePageState() {
    items.add(new MySuperHero("assets/1.jpeg",));
  }

  Widget superHeroCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () {
        //final snackBar = SnackBar(content: Text("Tap"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Animated()));
      },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img,width: 100,height: 100,),
                    ),
                    // SizedBox(
                    //   width: 16,
                    // ),
                    // Text(
                    //   items[index].title,
                    //   style:
                    //   TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
                //Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          ),);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => superHeroCell(context, index),
            ),
          ],
        ),
    );
  }
}