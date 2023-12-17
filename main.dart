import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_shit_app/form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // home: RandomIconScreen(),
        home: CalculatorApp());
  }
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "÷" ||
        buttonText == "×") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "÷") {
        _output = (num1 / num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget calculatorButton(
      String buttonText, Color buttonColor, Color textColor) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: textColor,
        backgroundColor: buttonColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20.0),
      ),
      onPressed: () => buttonPressed(buttonText),
      child: Text(buttonText, style: TextStyle(fontSize: 30)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.orange.shade200,
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                calculatorButton("C", Colors.grey, Colors.black),
                calculatorButton("⌫", Colors.grey, Colors.black),
                calculatorButton("÷", Colors.orange, Colors.white),
                calculatorButton("×", Colors.orange, Colors.white),
                calculatorButton("7", Colors.white, Colors.black),
                calculatorButton("8", Colors.white, Colors.black),
                calculatorButton("9", Colors.white, Colors.black),
                calculatorButton("−", Colors.orange, Colors.white),
                calculatorButton("4", Colors.white, Colors.black),
                calculatorButton("5", Colors.white, Colors.black),
                calculatorButton("6", Colors.white, Colors.black),
                calculatorButton("+", Colors.orange, Colors.white),
                calculatorButton("1", Colors.white, Colors.black),
                calculatorButton("2", Colors.white, Colors.black),
                calculatorButton("3", Colors.white, Colors.black),
                calculatorButton("=", Colors.orange, Colors.white),
                calculatorButton("0", Colors.white, Colors.black),
                calculatorButton(".", Colors.grey, Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RandomIconScreen extends StatefulWidget {
  const RandomIconScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomIconScreenState createState() => _RandomIconScreenState();
}

class _RandomIconScreenState extends State<RandomIconScreen> {
  IconData randomIcon = Icons.star; // Default icon

  void _changeIcon() {
    // Define a valid range for Material Icons Unicode code points
    int startCodePoint = 0xe000;
    int endCodePoint = 0xe8ff;

    setState(() {
      // Generate a random Unicode code point within the valid range
      int randomCodePoint =
          Random().nextInt(endCodePoint - startCodePoint) + startCodePoint;

      // Create an icon from the random Unicode code point
      randomIcon = IconData(randomCodePoint, fontFamily: 'MaterialIcons');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Icon App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              randomIcon,
              size: 100.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeIcon,
              child: const Text('Change Icon'),
            ),
          ],
        ),
      ),
    );
  }
}
// class RandomIconScreen extends StatefulWidget {
//   const RandomIconScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _RandomIconScreenState createState() => _RandomIconScreenState();
// }

// class _RandomIconScreenState extends State<RandomIconScreen> {
//   IconData randomIcon = Icons.star; // Default icon

//   void _changeIcon() {
//     List<IconData> icons = [
//       Icons.star,
//       Icons.access_alarm,
//       Icons.account_circle,
//       Icons.add_a_photo,
//       Icons.airport_shuttle,
//       // Add more icons if you want
//     ];

//     setState(() {
//       randomIcon = icons[Random().nextInt(icons.length)];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Random Icon App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize
//               .min, // Use min to reduce the column's size to fit its children
//           mainAxisAlignment:
//               MainAxisAlignment.center, // Center the children vertically
//           children: <Widget>[
//             Icon(
//               randomIcon,
//               size: 100.0,
//             ),
//             const SizedBox(
//                 height:
//                     20), // Provide some spacing between the icon and the button
//             ElevatedButton(
//               onPressed: _changeIcon,
//               child: const Text('Change Icon'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
