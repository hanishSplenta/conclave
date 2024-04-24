// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Add quiz'),
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
                      child: Container(
                        width: 200.0, // Set a width for each item
                        height: 70,
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5.0), // Add spacing
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(widget.quizes[index].id),
                      ),
                    ),
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
