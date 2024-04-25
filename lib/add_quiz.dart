import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/constants/constants.dart';
import 'package:conclave/custom/custom_button.dart';
import 'package:conclave/custom/spacers.dart';
import 'package:flutter/material.dart';
class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});
  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}
class _AddQuizPageState extends State<AddQuizPage> {
  final titleController = TextEditingController();
  final questionController = TextEditingController();
  final optionController = TextEditingController();
  final answerController = TextEditingController();
  List<String> options = [];
  bool created = false;
  createQuiz() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('conclaveQuiz');
    Map<String, dynamic> userData = {
      'questions': [],
      'status': 'active',
    };
    await collectionRef.doc(titleController.text).set(userData);
    const snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Text("Created Quiz!"),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    setState(() {
      created = true;
    });
    print('done');
  }
  Future<void> addQuestionToDoc(String collectionName, String documentId,
      Map<String, dynamic> newQuestion) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('conclaveQuiz');
    DocumentReference docRef = collectionRef.doc(titleController.text);
    try {
      await firestore.runTransaction((transaction) async {
        final documentSnapshot = await transaction.get(docRef);
        if (!documentSnapshot.exists) {
          throw Exception('Document does not exist!');
        }
        // Get the existing questions data
        // List<dynamic> existingQuestions = documentSnapshot.data()!['questions'] as List<dynamic>;
        // // Add the new question to the list
        // existingQuestions.add(newQuestion);
        // // Update the document with the modified questions list
        // transaction.update(docRef, {'questions': existingQuestions});
      });
      print('Question added successfully!');
    } catch (error) {
      print('Error adding question: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!created) ...[
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  decoration: InputDecoration(
                    label: const Text(
                      "Quiz name",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hintText: "enter feature title",
                    hintStyle: const TextStyle(
                      color: Color(0x00999999),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    // contentPadding:
                    //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(color: secondaryColor, width: 1),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: tertiaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
                VerticalSpacer(height: 20),
                CustomButton(
                  text: 'Create',
                  onTap: () {
                    createQuiz();
                  },
                )
              ],
              if (created) ...[
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: questionController,
                  decoration: InputDecoration(
                    label: const Text(
                      "Question",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hintText: "enter feature title",
                    hintStyle: const TextStyle(
                      color: Color(0x00999999),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    // contentPadding:
                    //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(color: secondaryColor, width: 1),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: tertiaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
                VerticalSpacer(height: 20),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: optionController,
                        decoration: InputDecoration(
                          label: const Text(
                            "add options",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          hintText: "enter feature title",
                          hintStyle: const TextStyle(
                            color: Color(0x00999999),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          // contentPadding:
                          //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8),
                          //   borderSide: BorderSide(color: secondaryColor, width: 1),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: tertiaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          options.add(optionController.text);
                          setState(() {});
                          optionController.clear();
                          print(options);
                        },
                        child: Text('Add'))
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical, // Set horizontal scrolling
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(options[index])),
                    );
                  },
                ),
                VerticalSpacer(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: answerController,
                  decoration: InputDecoration(
                    label: const Text(
                      "add answer",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    hintText: "enter feature title",
                    hintStyle: const TextStyle(
                      color: Color(0x00999999),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    // contentPadding:
                    //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(color: secondaryColor, width: 1),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: tertiaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
                VerticalSpacer(height: 20),
                CustomButton(
                  text: 'Add question',
                  onTap: () {},
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}