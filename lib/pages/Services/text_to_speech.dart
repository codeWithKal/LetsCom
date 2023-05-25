import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lets_com/pages/Services/sound_to_text.dart';



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
  bool _isMenuOpen = false;

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
      body: Stack(
        children: [ Padding(
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
          Positioned(
            right: 16.0,
            bottom: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                  child: Icon(Icons.menu),
                  tooltip: 'Services',
                ),
                SizedBox(height: 16.0),
                if (_isMenuOpen) ServicesMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // changes the shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              // Perform action when mic option is selected
              // Add your code here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => speech_to_text()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.keyboard),
            onPressed: () {
              // Perform action when keyboard option is selected
              // Add your code here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => text_to_speech()),
              );
            },
          ),
        ],
      ),
    );
  }
}

