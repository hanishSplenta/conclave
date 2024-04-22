import 'package:conclave/home_page.dart';
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
    // TODO: implement initState
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
        context, MaterialPageRoute(builder: (context) => ImageCapture()));
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
            duration: Duration(seconds: 1),
            opacity: opc ? 1 : 0,
            child: const Center(
                child: const Text(
              'Welcome',
              style: TextStyle(fontSize: 30, color: Colors.grey),
            )),
          )
        ],
      ),
    );
  }
}
