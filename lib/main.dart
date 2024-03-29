import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_timer_222410102043',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _minutes = 0;
  int _seconds = 0;
  bool _isActive = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _isActive = false;
            _timer.cancel();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('The timer has ended.'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    });
  }

  void stopTimer() {
    _isActive = false;
    _timer.cancel();
  }

  void resetTimer() {
    setState(() {
      _isActive = false;
      _minutes = 0;
      _seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto', fontSize: 25, fontWeight: FontWeight.normal),
        centerTitle: true,
        backgroundColor: Color(0xFFA1C398),
      ),
      backgroundColor: Color(0xFFD9EDBF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_minutes:${_seconds < 10 ? '0$_seconds' : _seconds}',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isActive = true;
                    });
                    startTimer();
                  },
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopTimer();
                  },
                  child: Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Set Timer'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    _minutes = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Minutes',
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    _seconds = int.parse(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Seconds',
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Set'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Set Timer'),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama: Nurul Hadits',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'NIM: 222410102043',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
