import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';



class text_to_speech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text to Speech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextToSpeechScreen(),
    );
  }
}

class TextToSpeechScreen extends StatefulWidget {
  @override
  _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  late FlutterTts flutterTts;
  late TextEditingController _textEditingController;
  double _volume = 0.5;
  double _pitch = 1.0;
  double _rate = 0.5;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _textEditingController = TextEditingController();
    initTts();
  }

  Future<void> initTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(_pitch);
    await flutterTts.setSpeechRate(_rate);
    await flutterTts.setVolume(_volume);
  }

  Future<void> speak() async {
    String text = _textEditingController.text;
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    flutterTts.stop();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            SizedBox(height: 16.0),
            Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              onChanged: (newValue) {
                setState(() {
                  _volume = newValue;
                  flutterTts.setVolume(_volume);
                });
              },
              label: 'Volume',
            ),
            Slider(
              value: _pitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              onChanged: (newValue) {
                setState(() {
                  _pitch = newValue;
                  flutterTts.setPitch(_pitch);
                });
              },
              label: 'Pitch',
            ),
            Slider(
              value: _rate,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              onChanged: (newValue) {
                setState(() {
                  _rate = newValue;
                  flutterTts.setSpeechRate(_rate);
                });
              },
              label: 'Rate',
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: speak,
                  child: Text('Speak'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: stop,
                  child: Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
