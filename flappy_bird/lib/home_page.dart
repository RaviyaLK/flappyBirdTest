import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1.5;
  static double barrierXtwo = barrierXone + 1.5;
  static double barrierXthree = barrierXtwo + 1.5;
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool birdIsDead() {
    if (birdYaxis < -1 || birdYaxis > 1) {
      return true;
    }
    // for (int i =0;  i<barrierXone; i++){
    //   if (barrierXone < 0.2 && barrierXone > -0.2){
    //     if (birdYaxis < -0.3 || birdYaxis > 0.3){
    //       return true;
    //     }
    //   }
    // }
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;

        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
        // barrierXthree -= 0.05;
      });
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      // setState(() {
      //   if (barrierXthree < -1) {
      //     barrierXthree += 3;
      //   } else {
      //     barrierXthree -= 0.05;
      //   }
      // });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
        // reset();z
      }
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            _showDialogBox();
          },
        );
      }
    });
  }

  showImage() {
    if (!birdIsDead()){
      return Image.asset(
        'lib/assets/TapToPlay.png',
        height: 80,
        width: MediaQuery.of(context).size.width * 0.5,);
    }
    if (birdIsDead()) {
      return Image.asset(
        'lib/assets/GameOver.png',
        height: 400,
        width: MediaQuery.of(context).size.width * 0.6,
      );
    }

  }
  

  void resetGame() {
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.5;
      barrierXtwo = barrierXone + 1.5;
      barrierXthree = barrierXtwo + 1.5;
    });
  }

  void _showDialogBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('GAME OVER'),
            content: const Text('Would you like to play again?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        resetGame();
                      },
                    );
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
          gameHasStarted = true;
        }
      },onForcePressStart: (details) {
          if (gameHasStarted) {
          jump();
        } else {
          startGame();
          gameHasStarted = true;
        }
      },
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted && !birdIsDead()
                        ? const Text('')
                        : showImage(),
                  ),
                  AnimatedContainer(
                      alignment: Alignment(barrierXone, 1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      )),
                  AnimatedContainer(
                      alignment: Alignment(barrierXone, -1),
                      duration: const Duration(milliseconds: 0),
                      child: const RotatedBox(
                          quarterTurns: 2,
                          child: MyBarrier(
                            size: 200.0,
                          ))),
                  AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      )),
                  AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1),
                      duration: const Duration(milliseconds: 0),
                      child: const RotatedBox(
                          quarterTurns: 2,
                          child: MyBarrier(
                            size: 150.0,
                          ))),
                  // AnimatedContainer(
                  //     alignment: Alignment(barrierXthree, 1),
                  //     duration: const Duration(milliseconds: 0),
                  //     child: const MyBarrier(
                  //       size: 200.0,
                  //     )),
                  // AnimatedContainer(
                  //     alignment: Alignment(barrierXthree, -1),
                  //     duration: const Duration(milliseconds: 0),
                  //     child: const RotatedBox(
                  //         quarterTurns: 2,
                  //         child: MyBarrier(
                  //           size: 150.0,
                  //         ))),
                ],
              )),
          Container(
            height: 25,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('SCORE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Text('0',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ]),
                    SizedBox(
                      width: 80,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('BEST',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text('10',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
