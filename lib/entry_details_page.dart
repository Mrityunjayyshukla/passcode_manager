import 'package:flutter/material.dart';

class RecordDetailsPage extends StatelessWidget {
  final Map<String, String> record;
  const RecordDetailsPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],

      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text(
          "Passcode Manager",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${record['Title']}'),
            Text('Title: ${record['Email']}'),
            Text('Password: ${record['Password']}'),
          ],
        ),
      ),
    );
  }
}