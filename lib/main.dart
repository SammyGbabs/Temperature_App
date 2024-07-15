import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF25D366),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF075E54),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF25D366),
        ),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
      ),
      home: TemperatureConverterHome(),
    );
  }
}

class TemperatureConverterHome extends StatefulWidget {
  @override
  _TemperatureConverterHomeState createState() =>
      _TemperatureConverterHomeState();
}

class _TemperatureConverterHomeState extends State<TemperatureConverterHome> {
  String _conversionType = 'F to C';
  final TextEditingController _controller = TextEditingController();
  String _convertedTemp = '';
  List<String> _history = [];

  void _convertTemperature() {
    setState(() {
      double inputTemp = double.tryParse(_controller.text) ?? 0.0;
      double convertedTemp;

      if (_conversionType == 'F to C') {
        convertedTemp = (inputTemp - 32) * 5 / 9;
      } else {
        convertedTemp = inputTemp * 9 / 5 + 32;
      }

      _convertedTemp = convertedTemp.toStringAsFixed(1);
      _history.add(
          '$_conversionType: ${inputTemp.toStringAsFixed(1)} => $_convertedTemp');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text(
                  'Fahrenheit to Celsius',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text(
                  'Celsius to Fahrenheit',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF25D366),
              ),
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted temperature: $_convertedTemp',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _history[index],
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
