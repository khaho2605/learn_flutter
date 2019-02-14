import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gradient_text/gradient_text.dart';

class SendMoney extends StatefulWidget {
 @override
  _SendMoneyState createState() => _SendMoneyState();
}

class StatusActionButton {
  final _value;
  const StatusActionButton._internal(this._value);
  toString() => 'Enum.$_value';

  static const Send = const StatusActionButton._internal('Send');
  static const Request = const StatusActionButton._internal('Request');
  static const Split = const StatusActionButton._internal('Split');
}

class _SendMoneyState extends State<SendMoney> {
  String _stringMoney = "";
  String _formatMoney = "";
  var _statusActionButton = StatusActionButton.Send;

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: _gradient(),
          child: Stack(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _headerWidget(),
                  SizedBox(height: 19),
                  _viewAction(),
                  SizedBox(height: 25),
                  _textTitle('TO'),
                  SizedBox(height: 10),
                  _toUser(),
                  SizedBox(height: 30),
                  _textTitle('AMOUNT'),
                  SizedBox(height: 17),
                  _numberMoney(),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height*279/667,
                child: _numberKeyboard(),
              ),
            ],
          ),
        ),
      );
    }

    Decoration _gradient() {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: _setColorGradient(_statusActionButton),
          tileMode: TileMode.repeated,
        ),
      );
    }

    List<Color> _setColorGradient(StatusActionButton status) {
      List<Color> listColor = [Color(0xFF9000ff), Color(0xFF005bce)];
      switch (status) {
        case StatusActionButton.Send:
          listColor = [Color(0xFF9000ff), Color(0xFF8100e1), Color(0xFF005cec), Color(0xFF005bce)];
          break;
        case StatusActionButton.Request:
          listColor = [Color(0xFFf7bb25), Color(0xFFff2424)];
          break;
        case StatusActionButton.Split:
          listColor = [Color(0xFF00a548), Color(0xFFbdd50a)];
          break;
      }
      return listColor;
    }

    Widget _headerWidget() {
      return SafeArea(
        child: Container(
          width:  double.infinity,
          height: 40,
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

    Widget _viewAction() {
      return Container(
        child: Column(
          children: <Widget>[
            _textTitle('I WANT'),
            _listButtonAction(),
          ],
        )
      );
    }

    Widget _toUser() {
      return Row(
        children: <Widget>[
          SizedBox(width: 30),
          Container(
            width: 80,
            height: 80,
            color: Colors.blue,
          )
        ],
      );
    }

    Widget _numberMoney() {
      return Row(
        children: <Widget>[
          SizedBox(width: 30),
          Image.asset(
            'lib/assets/images/icVndSmall.png',
            fit: BoxFit.scaleDown,
          ),
          SizedBox(width: 10),
          _textMoney(_formatMoney),
          SizedBox(width: 50),
        ],
      );
    }

    Widget _textMoney(String money) {
      return Text(
        money,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28
        ),
      );
    }

    Widget _numberKeyboard() {
      return SafeArea(
          child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 0),
          color: Colors.white.withAlpha(50),
          child: Stack(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Positioned(
                left: 30,
                right: 30,
                bottom: 14,
                height: 45,
                child: _nextContainer(),
              ),
              Positioned(
                // top: 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: _listButton(),
              )
            ],
          ),
        ),
      );
    }

    Widget _nextContainer() {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: Offset(0.0, 6),
              blurRadius: 20,
              spreadRadius: 0.0
            )
          ],
        ),
        child: _nextButton(),
      );
    }

    Widget _nextButton() {
      return RaisedButton(
        onPressed: () {
          setState(() {
            print("Next");
          });
        },
        child: GradientText(
          'NEXT',
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _setColorGradient(_statusActionButton)
          ),
          style: TextStyle(
            fontSize: 16,
          )
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5)),
      );
    }

    Widget _textTitle(String title) {
      return Row (
        children: <Widget>[
          SizedBox(width: 30),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontStyle: FontStyle.normal
            ),
          )
        ],
      );
    }

    Widget _listButtonAction() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 12),
          _actionButton('Send'),
          _actionButton('Request'),
          _actionButton('Split')
        ],
      );
    }
    Widget _actionButton(String title) =>  RaisedButton(
      onPressed: () {
        setState(() {
          _changeActionButon(title);
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28
        ),
      ),
      textColor: _updateColor(title),
      color: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 0.0,
      highlightElevation: 0.0,
      // padding: EdgeInsets.all(30),
    );

    void _changeActionButon(String title) {
      switch (title) {
        case 'Send':
          _statusActionButton = StatusActionButton.Send;
          break;
        case 'Request':
          _statusActionButton = StatusActionButton.Request;
          break;
        case 'Split':
          _statusActionButton = StatusActionButton.Split;
          break;
        default: break;
      }
    }

    Color _updateColor(String title) {
      if (title == _statusActionButton._value) {
        return Colors.white;
      } else {
        return Colors.white.withOpacity(0.5);
      }
    }

    Widget _listButton() => Column(
      children: <Widget>[
        _firstRow(),
        _rowButton(['4', '5', '6', '.']),
        _rowButton(['7', '8', '9', '0']),
      ],
    );

    Widget _firstRow() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _numberButton('1'),
          _numberButton('2'),
          _numberButton('3'),
          IconButton(
            padding: EdgeInsets.all(30),
            color: Colors.white,
            highlightColor: Colors.white,
            splashColor: Colors.white,
            icon: new Image.asset(
                'lib/assets/images/icKeyboardDeleteV2.png',
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_stringMoney.length > 0) {
                  _stringMoney = _stringMoney.substring(0, _stringMoney.length - 1);
                  _formatNumer(_stringMoney);
                }
              });
            },
          )
        ],
      );
    }
    Widget _rowButton(List<String> listTitle) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
      _numberButton(listTitle[0]),
      _numberButton(listTitle[1]),
      _numberButton(listTitle[2]),
      _numberButton(listTitle[3]),
      ],
    );

    Widget _numberButton(String title) =>  RawMaterialButton(
      onPressed: () {
        setState(() {
          _stringMoney += title;
          _formatNumer(_stringMoney);
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Lato-Light",
          fontSize: 24,
          color: Colors.white
        ),
      ),
      // textColor: Colors.white,
      // color: Colors.transparent,
      highlightColor: Colors.white.withOpacity(0.3),
      elevation: 0.0,
      highlightElevation: 0.0,
      padding: EdgeInsets.all(20),
      shape: CircleBorder(),
      fillColor: Colors.transparent,
      splashColor: Colors.transparent,
    );

    void _formatNumer(String number) {
      if (number == "") {
        _formatMoney = "";
        return;
      }
      var controller = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
      controller.updateValue(double.parse(_stringMoney));
      print(number);
      _formatMoney = controller.text.substring(0,  controller.text.length - 3);
    }
}