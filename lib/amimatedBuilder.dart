import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp((SecondPage()));
}
class SecondPage extends StatelessWidget {
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
        body: Column(
        children: <Widget>[
            Expanded(child: Spinner(),),
            Expanded(child: AnimatedContain(),),
          Expanded(child: SizeTrans(),)
            ],
            ),
    ),);
  }
}
class Spinner extends StatefulWidget {
  @override
  _SpinnerState createState() => _SpinnerState();
}
class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )
      ..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children:<Widget>[Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimatedBuilder(
            animation: _controller,
          child: Container(width: 50.0, height: 50.0, color: Colors.indigo,alignment: Alignment.center,),
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * math.pi,
              child: child,
            );
          },
         ),
      ),
       ),
          // Container(
          //   child: Hero(
          //     tag: "Img",
          //     child: Image.asset("assets/2.jpeg",width: 100,height: 150,),
          //   ),
          // ),
    ],));
  }
}
class AnimatedContain extends StatefulWidget {
@override
_AnimatedState createState() => _AnimatedState();
}
class _AnimatedState extends State<AnimatedContain> with SingleTickerProviderStateMixin {
  final double smallLogo = 100;
  final double bigLogo = 200;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
            builder: (context,constraints){
              final Size biggest = constraints.biggest;
              return Stack(
                children: [
                  PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                            Rect.fromLTWH(0, 0, smallLogo, smallLogo), biggest),
                        end: RelativeRect.fromSize(
                            Rect.fromLTWH(biggest.width - bigLogo,
                                biggest.height - bigLogo, bigLogo, bigLogo),
                            biggest),
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.elasticInOut,
                           )),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/1.jpeg"),
                      )
                  )
                ],
              );
            }
        );
  }
}
class SizeTrans extends StatefulWidget {
  SizeTrans({Key key}) : super(key: key);
  @override
  _SizeState createState() => _SizeState();
}
class _SizeState extends State<SizeTrans> with TickerProviderStateMixin {
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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        axisAlignment: -1,
        child:Center(
        //Padding(
         // padding: EdgeInsets.all(5.0),
          child: FlutterLogo(size: 100,),
        ),
      ),
    );
  }
}
