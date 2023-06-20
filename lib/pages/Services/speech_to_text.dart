import 'package:flutter/material.dart';
import 'package:lets_com/pages/Services/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class speech_to_text extends StatefulWidget {
  @override
  _speech_to_text createState() => _speech_to_text();
}

class _speech_to_text extends State<speech_to_text> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done') {
            _speech.stop();
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (error) {
          print('Error: $error');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _text,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 20.0),
                FloatingActionButton(
                  onPressed: _listen,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
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