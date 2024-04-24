// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/models/quiz_model.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String quiz;
  const QuizPage({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int q = 0;
  List<Questions> questions = [];

  getDocuments() async {
    final collectionRef =
        FirebaseFirestore.instance.collection('conclaveQuiz').doc(widget.quiz);
    final doc = await collectionRef.get();
    if (!doc.exists) {
      return null; // Document doesn't exist
    }

    final data = doc.data();

    // if (data == null || data['webViews'] == null) {
    //   return []; // No views array in the document
    // }

    // Get the views list from the data
    final views = data!['questions'] as List;

    // Extract titles from each view
    final List<Questions> _features = views
        .map((view) => Questions.fromJson(view as Map<String, dynamic>))
        .toList();
    setState(() {
      questions = _features;
    });

    print(_features[0].question.toString());

    // return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(questions[q].question ?? ''),
            TextButton(
                onPressed: () {
                  if (q < questions.length - 1) {
                    setState(() {
                      q++;
                    });
                    print(q);
                  }
                },
                child: q < questions.length - 1 ? const Text('next') : const Text('Finish'))
          ],
        ),
      ),
    );
  }
}
