import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'sign_up.dart';
import 'animation.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter/cupertino.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  SequenceAnimation _sequenceAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =AnimationController(vsync: this);
    _sequenceAnimation = SequenceAnimationBuilder()
    // .addAnimatable(
    //   animatable: ColorTween(begin: Colors.red.withOpacity(0), end:  Colors.red.withOpacity(1)),
    //   from: Duration(seconds: 0),
    //   to: Duration(seconds: 2),
    //   tag: 'color'
    // )
    .addAnimatable(
      animatable: Tween<double>(begin: 0, end: -300),
      from: Duration(seconds: 0),
      to: Duration(seconds: 2),
      tag: 'move'
    )
    // .addAnimatable(
    //   animatable: ColorTween(begin: Colors.green, end:  Colors.yellow),
    //   from: Duration(seconds: 2),
    //   to: Duration(seconds: 3),
    //   tag: 'color'
    // )
    // .addAnimatable(
    //   animatable: ColorTween(begin: Colors.yellow, end:  Colors.pink),
    //   from: Duration(seconds: 3),
    //   to: Duration(seconds: 6),
    //   tag: 'color'
    // )
    // .addAnimatable(
    //   animatable: Tween<double>(begin: 100, end:  200),
    //   from: Duration(seconds: 0),
    //   to: Duration(seconds: 3),
    //   tag: 'size'
    // )
    .animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('SIGN UP'),
      ),
      body: _buttonSignIn()
    );
  }

  Widget _animation1() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            // return Container(
            //   height: _sequenceAnimation['size'].value,
            //   width: _sequenceAnimation['size'].value,
            //   color: _sequenceAnimation['color'].value,
            //   // decoration: BoxDecoration(
            //   //   borderRadius: BorderRadius.circular(10),
            //   //   color: _sequenceAnimation['color'].value
            //   // ),
            // );
            return _moveWidget();
          },
        ),
      ),
    );
  }

  Widget _moveWidget() {
    final double width = MediaQuery.of(context).size.width;
    return Transform(
      transform: Matrix4.translationValues(0.0,_sequenceAnimation['move'].value * 2, 0.0),
      child: FlutterLogo(size: 100.0),
    );
  }

  Widget _animation() {
    return Center(
      child: Container(
        child: MyAnimator(),
      ),
    );
  }

  Widget _buttonSignIn() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => SignUp()));
          });
        },
        child: Text(
          'SIGN IN'
        ),
      ),
    );
  }
}

class MyAnimator extends StatefulWidget {
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<MyAnimator>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this);
    animation = Tween(begin: 0.0, end: -600.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: _moveWidget()
    );
  }

  Widget _zoomWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  Widget _moveWidget() {
    return Baseline(
      baseline: animation.value,
      baselineType: TextBaseline.alphabetic,
      child: FlutterLogo(size: 100.0),
    );
  }
}