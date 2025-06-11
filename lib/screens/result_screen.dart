import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultScreen extends StatelessWidget {
  final String rawMessage;
  final String polishedMessage;
  final String tone;

  const ResultScreen({
    super.key,
    required this.rawMessage,
    required this.polishedMessage,
    required this.tone,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: polishedMessage));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Message copied to clipboard!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Polished Message',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 74, 91),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Raw Message:",
              style: TextStyle(
                color: const Color.fromARGB(255, 67, 66, 66),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Text(rawMessage),
            ),
            SizedBox(height: 24),
            Text(
              "Polished Message (Tone: $tone):",
              style: TextStyle(
                fontSize: 19,
                color: const Color.fromARGB(255, 67, 66, 66),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Text(polishedMessage),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _copyToClipboard(context),
                icon: Icon(Icons.copy, color: Colors.white),
                label: Text(
                  'Copy Message',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 74, 91),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
