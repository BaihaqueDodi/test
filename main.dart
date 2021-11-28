import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:uber_clone/Sidebar/sidebar.dart';
import 'package:Safe_Ride/states/app_state.dart';
import 'screens/home.dart';
// import 'package:uber_clone/Sidebar/sidebarlayout.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppState(),
        )
      ],

      child: MyApp(),
      // sideBarLayout(),
    ),
  );
}

class MyApp extends StatelessWidget {
  AudioCache _audioCache;
  @override
  void initState() {
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    // super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Ride',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Map(),
    );
  }


}
