import 'package:flutter/material.dart';
import '../logic/converter_logic.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  void _convert() {
    double kilometers = double.tryParse(_controller.text) ?? 0;
    double miles = ConverterLogic.convertKilometersToMiles(kilometers);
    setState(() {
      _result = "${miles.toStringAsFixed(2)} Miles";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kilometer to Mile Converter"),
        backgroundColor: Colors.deepOrangeAccent.shade400,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter value in kilometers',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent.shade400,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
