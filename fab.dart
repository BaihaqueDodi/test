import 'dart:async';

import 'package:flutter/material.dart';
// import './screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();

String alarm;


 AudioCache player = AudioCache();

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  FancyFab({this.onPressed, this.tooltip, this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    Timer.periodic(Duration(seconds: 1), (Timer t){
      getData();
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: (Colors.blue),
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    // getData(); // call getData function everytime floatingActionButton is pressed
    isOpened = !isOpened;
  }

  Widget toggle() {
    return new Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        // database.reference().update(                            //tak guna sbb utk update
        //  {"alarmStatus": "mnyala"}), //send data to firebase
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        toggle(),
      ],
    );
  }

  // get data from firebase
  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      var data = snapshot.value; // store all value from database to data variable
      alarm = data['alarm']; // access "alarm" value
      // print(alarm);
      
      if(alarm=="on")
      {
        final player = AudioCache();
        player.play("audio/censore.mp3");
      }
    });
  }
}

