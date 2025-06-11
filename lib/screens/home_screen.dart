import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../services/ai_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedTone = 'Formal';

  final List<String> _tones = [
    'Formal',
    'Friendly',
    'Confident',
    'Funny',
    'Apologetic',
    'Assertive',
  ];

  bool _isLoading = false;

  void _polishMessage() async {
    final rawMessage = _messageController.text.trim();
    if (rawMessage.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Call the AI Service to get the polished message.
    final polishedMessage = await AIService.getPolishedMessage(
      rawMessage,
      _selectedTone,
    );

    setState(() {
      _isLoading = false;
    });

    // Navigate to the ResultScreen with the polished message.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResultScreen(
              rawMessage: rawMessage,
              polishedMessage: polishedMessage,
              tone: _selectedTone,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Message Polisher',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 74, 91),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your raw message here...',
                hintStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Select Tone: ',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 67, 66, 66),
                  ),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedTone,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedTone = value;
                      });
                    }
                  },
                  items:
                      _tones.map((tone) {
                        return DropdownMenuItem(value: tone, child: Text(tone));
                      }).toList(),
                ),
              ],
            ),
            SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _polishMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 74, 91),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text(
                    'Polish Message',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
