import 'package:flutter/material.dart';

import 'image_capture.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  @override
  void initState() {
    nextTask();
    super.initState();
  }

  nextTask() async {
    setState(() {
      opc = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      opc = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      opc = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ImageCapture()));
  }

  bool opc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/greeting_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: opc ? 1 : 0,
            child: const Center(
                child: Text(
              'Welcome',
              style: TextStyle(fontSize: 50, color: Colors.grey),
            )),
          )
        ],
      ),
    );
  }
}
