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
        home: ItemForm());
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
