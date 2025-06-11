import 'dart:convert';
//import 'package:ai_message_polisher/secrets.dart';
import 'package:ai_message_polisher/secrets_sample.dart';
import 'package:http/http.dart' as http;

class AIService {
  // Replace with your actual OpenAI API key
  static String apiKey = Secrets.openAiApiKey;

  static Future<String> getPolishedMessage(
    String rawMessage,
    String tone,
  ) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a helpful assistant that rewrites messages in a given tone.",
        },
        {
          "role": "user",
          "content":
              "Please rewrite the following message in a $tone tone:\n\n$rawMessage",
        },
      ],
      "temperature": 0.7,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      print("📥 Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final polishedText = data['choices'][0]['message']['content'];
        return polishedText.trim();
      } else {
        return "❌ Error ${response.statusCode}: ${response.reasonPhrase}";
      }
    } catch (e) {
      print("❌ Exception: $e");
      return "An error occurred while contacting OpenAI.";
    }
  }
}
