// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/add_quiz.dart';
import 'package:conclave/custom/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class ManageQuizes extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> quizes;
  const ManageQuizes({
    Key? key,
    required this.quizes,
  }) : super(key: key);

  @override
  State<ManageQuizes> createState() => _ManageQuizesState();
}

class _ManageQuizesState extends State<ManageQuizes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Quizes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AddQuizPage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Add quiz'),
                    ),
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical, // Set horizontal scrolling
                itemCount: widget.quizes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomListTile(
                            title: widget.quizes[index].id,
                            subtitle: "sadnvcsndm",
                            onTap: () {})),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
