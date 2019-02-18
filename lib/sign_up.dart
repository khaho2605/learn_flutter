import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:after_layout/after_layout.dart';

class SignUp extends StatefulWidget {
_SignUpState createState() => _SignUpState(); 
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  AnimationController _controller;
  SequenceAnimation _sequenceAnimation;
  double height = 1000;

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    height = MediaQuery.of(context).size.height;
  }

  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _sequenceAnimation = SequenceAnimationBuilder()

    .addAnimatable(
      animatable: Tween<double>(begin: 50, end: 0.0),
      from: Duration(seconds: 1),
      to: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      tag: "moveTitle"
    )

    .addAnimatable(
      animatable: ColorTween(begin: Colors.red.withOpacity(0), end:  Colors.red.withOpacity(1)),
      from: Duration(milliseconds: 1),
      to: Duration(seconds: 2),
      tag: 'color'
    )
    .addAnimatable(
      animatable: ColorTween(begin: Colors.black.withOpacity(0), end:  Colors.black.withOpacity(1)),
      from: Duration(seconds: 1),
      to: Duration(seconds: 3),
      tag: 'colorOpacity'
    )
    .animate(_controller);
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tranform(),
    );
  }

  Widget _tranform() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          body: _mainContainer()
        );
      }
    );
  }

  Widget _mainContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Column(
            children: <Widget>[
              _headerWidget(),
              SizedBox(height: 56),
              _setTranform(_titleText(), 'moveTitle'),
         
              SizedBox(height: 56),
              // _textFieldPhoneNumer(), 
              // SizedBox(height: 19),
              // _infoLabel()
            ]
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: _bottom()
          )
        ],
      ),
    );
  }

  Widget _setTranform(Widget _widget, String tagAnimation) {
    return Transform(
      transform: Matrix4.translationValues(0.0,_sequenceAnimation[tagAnimation].value, 0.0),
      child: _widget,
    );
  }

  Widget _headerWidget() {
    return SafeArea(
      child: Container(
        width:  double.infinity,
        height: 40,
        color: _sequenceAnimation['color'].value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _closeButton(),
            _logoWee()
        ],
        )
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        child: Image.asset(
          '/Users/kha/Desktop/Workspace/Flutter/learn_flutter/lib/assets/images/icClose.png',
            fit: BoxFit.scaleDown,
        ),
      ),
      onTap: () {
        print("click back");
        Navigator.of(context).pop();
      },
    );
  }

  Widget _logoWee() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Image(
        image: AssetImage(
          '/Users/kha/Desktop/Workspace/Flutter/learn_flutter/lib/assets/images/icLogo.png'
        ),
        fit:  BoxFit.cover,
      ),
    );
  }

  Widget _titleText() {
    return  Row(
      children: <Widget>[
        SizedBox(width: 30,),
        Text(
          'Sign up with your\nphone number',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 34,
            color: _sequenceAnimation['colorOpacity'].value
          ),
        )
      ],
    );
  }

  Widget _textFieldPhoneNumer() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
          decoration: InputDecoration(
          labelText: 'Enter phone number',
          // labelStyle: TextStyle(
          //   color: Colors.red,
          //   fontSize: 15.0
          // ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 25.0
          )
        ),
      )
    );
  }

  Widget _infoLabel() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: new RichText(
        text: new TextSpan(
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(text: 'By signing up you agree to the '),
            _serviceText('terms of service '),
            new TextSpan(text: 'and '),
            _serviceText('privacy policy')
          ],
        ),
      ),
    );
  }

  TextSpan _serviceText(String text) {
   return TextSpan(
      text: text,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
      recognizer: TapGestureRecognizer()..onTap = () {
        print(text);
      },
    );
  }
 
  Widget _bottom() {
    return Column (
      children: <Widget>[
        Text(
          'Already have an account ?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        _nextButton()
      ],
    );
  }

  Widget _nextButton() {
    return Container(
      child: GestureDetector(
        onTap: () {
            print("click Sign In");
        },
        child: GradientText(
          'SIGN IN',
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF00cfff), Color(0xFF0065ff)]
          ),
          style: TextStyle(
            fontSize: 16,
          )
        ),
      ),
    );
  }
}
