import 'package:conclave/custom/spacers.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatefulWidget {
  final int score;
  const ScoreBoard({super.key, required this.score});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            VerticalSpacer(height: 40),
            Row(
              children: [IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close))],
            ),
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text('You scored ${widget.score} points'),
            ),

          ],
        ),
      ),
    );
  }
}