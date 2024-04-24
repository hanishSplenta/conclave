// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:conclave/custom/spacers.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';
import 'package:page_transition/page_transition.dart';

import 'package:conclave/quiz_page.dart';

import 'custom/spacers.dart';

class QuizHome extends StatefulWidget {
  final String quiz;
  const QuizHome({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.quiz),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            VerticalSpacer(height: 20),
            const Text('Hi !'),
            VerticalSpacer(height: 20),
            const Center(
              child: Text(
                'Welcome to quizCorner. this section will \n have multipple choice questions \n mainly on finance and banking',
                textAlign: TextAlign.center,
              ),
            ),
            VerticalSpacer(height: 20),
            const Center(
              child: Text(
                'You will get 12 seconds to answer a question, \n Good Luck !',
                textAlign: TextAlign.center,
              ),
            ),
            VerticalSpacer(height: 20),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 0),
                      ),
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [Text('Leader board')],
                  )),
                ),
              ),
            )),
            VerticalSpacer(height: 20),
            NeoPopTiltedButton(
              isFloating: true,
              onTapUp: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: QuizPage(
                          quiz: widget.quiz,
                        )));
              },
              decoration: const NeoPopTiltedButtonDecoration(
                color: Color.fromRGBO(255, 235, 52, 1),
                plunkColor: Color.fromRGBO(255, 235, 52, 1),
                shadowColor: Color.fromRGBO(36, 36, 36, 1),
                showShimmer: true,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 120.0,
                  vertical: 15,
                ),
                child: Text('Attempt Quiz'),
              ),
            ),
            VerticalSpacer(height: 10)
          ],
        ),
      ),
    );
  }
}
