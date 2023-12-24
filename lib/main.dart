import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MSubPlayer(),
    );
  }
}

class MSubPlayer extends StatefulWidget {
  const MSubPlayer({super.key});

  @override
  State<MSubPlayer> createState() => _MSubPlayerState();
}

class _MSubPlayerState extends State<MSubPlayer> {
  bool isShowing = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            isShowing = !isShowing;
          });
          debugPrint(isShowing.toString());
          if (isShowing) {
            startTimer();
          } else {
            if (timer != null) {
              timer!.cancel();
            }
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: AnimatedOpacity(
            opacity: isShowing ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(child: Icon(Icons.replay_10)),
                      InkWell(
                          onTap: () {
                            debugPrint('Play Button Clicked');
                            if (timer != null) {
                              timer!.cancel();
                              startTimer();
                            }
                          },
                          child: const CircleAvatar(
                              child: Icon(Icons.play_arrow))),
                      const CircleAvatar(child: Icon(Icons.forward_10)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: double.infinity,
                    height: 3,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isShowing = false;
      });
      debugPrint(isShowing.toString());
    });
  }
}
