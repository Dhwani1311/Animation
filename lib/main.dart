import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation/amimatedBuilder.dart';
//import 'package:flutter_animation/animatedContainer.dart';
import 'package:flutter_animation/defaultText.dart';

void main() {
  runApp(MyApp());
}
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
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
        ),
        body: MyHomePage(),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  AlignmentGeometry align = Alignment.topRight;
  bool _selected = false;
  double _fontSize = 30;
  Color _color = Colors.grey;
  double _left = 20;
  double _top = 20;
  double _right = 20;
  double _bottom = 20;
  double _width = 100;
  double _height = 100;
  bool selected = false;
  double opacityLevel = 1.0;
  bool _first = true;
  bool _choose = true;
  bool _sec = true;
  EdgeInsetsGeometry _padding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollView(
        child:Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              color: Colors.lightBlueAccent[40],
              child: AnimatedAlign(
                alignment: align,
                curve: Curves.ease,
                duration: Duration(seconds: 2),
                child: FlutterLogo(
                  size: 50,
                ),
              )
          ),
          FlatButton(
            onPressed: () {
              _changeAlign();
            },
            child: Text("Click me",),
          ),
          Container(
            height: 100,
            child: AnimatedDefaultTextStyle(
              duration: Duration(seconds: 1),
              style: TextStyle(
                fontSize: _fontSize,
                color: Colors.indigo,
              ),
              child: Text("Hello"),
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                _fontSize = _selected ? 60 : 30;
                _color = _selected ? Colors.lightBlueAccent : Colors.yellow;
                _selected = !_selected;
              },);
            },
            child: Text("Press"),
          ),

          Container(child: GestureDetector(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Center(
                child: AnimatedContainer(
                  width: selected ? 100 : 150,
                  height: selected ? 100 : 150,
                  color: selected ? Colors.black26 : Colors.lightGreen,
                  alignment: selected ? Alignment.center : AlignmentDirectional
                      .topCenter,
                  duration: Duration(seconds: 3),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FlutterLogo(size: 50,),
                )
            ),

          ),),
         Container(
           child: AnimatedCrossFade(
             duration: const Duration(seconds: 3),
             firstChild: const FlutterLogo(
                 style: FlutterLogoStyle.horizontal, size: 100.0),
             secondChild: const FlutterLogo(
                 style: FlutterLogoStyle.stacked, size: 100.0),
             crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState
                 .showSecond,
           )
         ),
          FlatButton(onPressed: (){
            setState(() {
              _first = !_first;
            });
          },
              child: Text("Click me")),
          Container(
            child: new FlatButton(
              onPressed: (() {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => SecondPage()));
              }),
              child: new Text('click'),),
          ),
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue[50],
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: 3),
              child: FlutterLogo(size: 60,),
            ),
          ),
          FlatButton(
              onPressed: _changeOpacity,
              child: Text("Fade Logo",)),
          Container(
            height: 100,
            width: 100,
            child: AnimatedPadding(
              padding: _padding,
              curve: Curves.ease,
              duration: Duration(seconds: 1),
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              _changePadding();
            },
            child: Text(
              "Click Me!",
            ),
          ),
          Container(
            child: AnimatedPhysicalModel(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                elevation: _first ? 0 : 6.0,
                shape: BoxShape.rectangle,
                shadowColor: Colors.black,
                color: Colors.white,
                borderRadius: _first ? const BorderRadius.all(Radius.circular(0)) : const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  color: Colors.blue[50],
                  child: FlutterLogo(
                    size: 60,),
                )
           ),
          ),
          SizedBox(height: 10,),
          RaisedButton(
            child: const Text('Click Me!'),
            onPressed: () {
              setState(() {
                _first = !_first;
              });
            },
          ),
          Container(
            height: 100,
            width: 100,
            child:Stack(
              children:<Widget>[
                AnimatedPositioned(
                    child: Container(color: Colors.red,),
                    duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                    left: _left,
                    top: _top,
                    bottom: _bottom,
                    right: _right,
            ),
          ],),),
          SizedBox(height:10,),
         RaisedButton(onPressed: (){
            setState(() {
              _left = _choose ? 20 : 30;
              _top = _choose ? 50 : 20;
              _bottom = _choose ? 50 : 20;
              _right = _choose ? 20 : 30;
              _choose = !_choose;
            });
          },

              child: Text("click!")),
        Container(
          height: 100,
          child: Center(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: Container(
                width: _width,
                height: _height,
                color: Colors.blue,
              ),
              vsync:this,
            ),
          ),
        ),

        SizedBox(height: 10,),
        FlatButton(
          child: const Text('CLICK ME!'),
          onPressed: () {
            setState(() {
              _width  = _sec ?  110 : 100;
              _height = _sec ?  80 : 100;
              _sec = !_sec;
            });
          },
        ),
        SizedBox(height: 10,),
          // RaisedButton(
          //     child: Text("CLICk"),
          //     onPressed: (){
          //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Animated()));
          //     }
          // ),
        RaisedButton(
          child: Text("Count"),
            onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHome()));
            }
        ),
          RaisedButton(
              child: Text("Click me"),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage()));
              }
          ),

        ],),
    ),);
  }

  void _changeAlign() {
    setState(() {
      align = align == Alignment.topRight ? Alignment.bottomLeft : Alignment.topRight;
    });
  }
  void _changePadding() {

    setState(() {
      // ignore: unrelated_type_equality_checks
      if (_padding == 100) {
        _padding = EdgeInsets.only(top: 100, bottom: 100);
      } else {
        _padding = EdgeInsets.only(left: 100, right: 100);
      }
    });
  }
  _changeOpacity() {
    setState(() {
      opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
    },);
  }
}

