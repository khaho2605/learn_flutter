import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'action_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new SendMoney(),
    );
  }
}

class KeyboardLockView extends StatefulWidget {
  final Function(String) passwordChange;
  KeyboardLockView({Key key,this.passwordChange}): super(key: key);

  @override
  _KeyboardLockViewState createState() => _KeyboardLockViewState();
}

class _KeyboardLockViewState extends State<KeyboardLockView> {
  String password = "";
  bool pressAttention = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00cfff),
      appBar: AppBar(
        title: Text('Row & Column'),
      ),
      body: SingleChildScrollView(
        child: _listButton()
      ),
    );
  }

  Widget _listButton() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      SizedBox(height: 10, width: 0),
      _gradientView(),
      SizedBox(height: 15, width: 0),
      _rowButton(['1', '2', '3']),
      SizedBox(height: 15, width: 0),
      _rowButton(['4', '5', '6']),
      SizedBox(height: 15, width: 0),
      _rowButton(['7', '8', '9']),
      SizedBox(height: 15, width: 0),
      _lastRow()
    ],
  );

  Widget _gradientView() => Container (
    width: double.infinity,
    height: 75,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: _setListCircle(password),
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: _setColorGradient(password),
        tileMode: TileMode.repeated,
      ),
    ),
  );

  Widget _rowButton(List<String> listTitle) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
     _numberButton(listTitle[0]),
     _numberButton(listTitle[1]),
     _numberButton(listTitle[2]),
    ],
  );

  Widget _lastRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(30),
        ),
      _numberButton('0'),
      IconButton(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: new Image.asset(
            '/Users/kha/Desktop/Workspace/Flutter/learn_flutter/lib/assets/images/icKeyboardDeleteV2.png',
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            if (password.length > 0) {
              password = password.substring(0, password.length - 1);
              widget.passwordChange(password);
            }
          });
          print(password);
        },
      )
      ],
  );

  List<Widget> _setListCircle(String text) {
    List<Widget> listCircle;
    switch (text.length) {
      case 0:
        listCircle = [];
        break;
      case 1:
        listCircle = [
          _whiteCircle(),
          SizedBox(height: 0, width: 150),
        ];
        break;
      case 2:
        listCircle = [
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle(),
          SizedBox(height: 0, width: 100),
        ];
        break;
      case 3:
        listCircle = [
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle(),
          SizedBox(height: 0, width: 50),
        ];
        break;
      case 4:
        listCircle = [
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle(),
          SizedBox(height: 0, width: 30),
          _whiteCircle()
        ];
        break;
      default:
        break;
    }
    return listCircle;
  }

  List<Color> _setColorGradient(String text)  {
    List<Color> listColor = [Color(0xFFf7bb25), Color(0xFFff2424)];
    switch (text.length) {
      case 0:
        listColor = [Color(0xFF005cec), Color(0xFF005bec)];
        break;
      case 1:
        listColor = [Color(0xFF9000ff), Color(0xFF8100e1), Color(0xFF005cec), Color(0xFF005bce)];
        break;
      case 2:
        listColor = [Color(0xFFf7bb25), Color(0xFFff2424)];
        break;
      case 3:
        listColor = [Color(0xFF00a548), Color(0xFFbdd50a)];
        break;
      default:
        break;
    }
    return listColor;
  }

  Widget _whiteCircle() => Container(
    width: 20,
    height: 20,
    decoration: new BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
  );

  Widget _numberButton(String title) =>  RaisedButton(
    onPressed: () {
      setState(() {
        if (password.length < 4) {
          password += title;
          widget.passwordChange(password);
        }
      });
      print(password);
    },
    child: Text(
      title,
      style: TextStyle(
        fontFamily: "Lato-Light",
        fontSize: 24
      ),
    ),
    textColor: Colors.white,
    color: Colors.transparent,
    highlightColor: Colors.white,
    elevation: 0.0,
    highlightElevation: 0.0,
    padding: EdgeInsets.all(30),

    shape: CircleBorder(
      side: BorderSide(color: Colors.white, width: 1),
    ),
  );
}
