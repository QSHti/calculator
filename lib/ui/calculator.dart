import 'package:flutter/material.dart';
import '../logic/calculator_logic.dart';
import '../ui/converter.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorLogic _logic = CalculatorLogic();

  void buttonClick(String buttonText) {
    setState(() {
      if ('0123456789.'.contains(buttonText)) {
        _logic.inputDigit(buttonText);
      } else {
        switch (buttonText) {
          case 'C':
            _logic.clear();
            break;
          case '±':
            _logic.toggleSign();
            break;
          case '%':
            _logic.calculatePercentage();
            break;
          case '+':
          case '-':
          case '*':
          case '/':
            _logic.inputOperation(buttonText);
            break;
          case '=':
            _logic.finalizeCalculation();
            break;
          default:
            break;
        }
      }
    });
  }

  Widget buildButton(String buttonText) {
    String logicSymbol = buttonText;
    if (buttonText == '/') logicSymbol = '/';
    if (buttonText == '*') logicSymbol = '*';
    return Expanded(
      child: RawMaterialButton(
        onPressed: () => buttonClick(logicSymbol),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Explicitly setting the text color to white for visibility
          ),
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.grey[850], // Using a darker color for the button background
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent.shade400,
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
               child: Text(
                _logic.history,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: Text(
              _logic.currentInput.isEmpty ? _logic.currentResult : _logic.currentInput,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ConverterPage()));
              },
              child: const Text(
                'Convert Kilometers to Miles',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),


          Divider(thickness: 2),
          // Here we will have a row for each calculator button row
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("/"),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("*"),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("-"),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            buildButton("."),
            buildButton("0"),
            buildButton("00"),
            buildButton("+"),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            buildButton("C"),
            buildButton("±"),
            buildButton("%"),
            buildButton("="),
          ]),
        ],
      ),
    );
  }
}