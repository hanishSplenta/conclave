import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/constants/constants.dart';
import 'package:conclave/greetings_screen.dart';
import 'package:conclave/services/storage_services.dart';
import 'package:conclave/utils/random.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neopop/neopop.dart';
import 'package:page_transition/page_transition.dart';

import 'custom/spacers.dart';

class OtpVericationScreen extends StatefulWidget {
  const OtpVericationScreen({super.key});

  @override
  State<OtpVericationScreen> createState() => _OtpVericationScreenState();
}

class _OtpVericationScreenState extends State<OtpVericationScreen> {
  String mob = "";
  FirebaseAuth? _auth;
  String _verificationId = "";
  bool loading = false;
  String otp = "";

  getMobNo(FirebaseAuth _auth) async {
    setState(() {
      loading = true;
    });

    mob = await LocalStorageService().loadData('mobNo') ?? '';

    if (mob != '') {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: "+91$mob",
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Automatically sign in the user if code is already verified
            await _auth.signInWithCredential(credential);
            // Handle successful sign-in logic

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("verification complete")),
            );
          },
          verificationFailed: (FirebaseAuthException e) {
            // Handle verification failure errors

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? "")),
            );
          },
          codeSent: (String verificationId, [int? resendToken]) {
            // Show message that code has been sent
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Verification code sent')),
            );

            // Store verificationId for later use
            setState(() {
              _verificationId = verificationId;
              loading = false;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle code auto-retrieval timeout
            setState(() {
              _verificationId = verificationId;
            });
          },
        );
      } catch (e) {
        // Handle other errors
        print("$e----------------");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
    }
  }

  showNameByNumber() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final num = await LocalStorageService().loadData('mobNo') ?? '';
      final querySnapshot = await firestore
          .collection('employee_details_v2')
          .where('MobileNo', isEqualTo: num)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        final userData = docSnapshot.data();
        Random().showAutoDismissingPopup(
            context,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  HorizontalSpacer(width: 20),
                  Text('Signing in as ${userData['Name']}'),
                ],
              ),
            ));
        // return userData['Name'];
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    // return null; // Indicate name not found
  }

  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    getMobNo(_auth!);
    showNameByNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    // TextEditingController employeeIdController = TextEditingController();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(
            'assets/icons/bg.svg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            // height: 100,
            // width: mq.size.width,
            width: width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacer(height: 10),
                  Text('OTP sent to $mob'),
                  VerticalSpacer(height: 20),
                  OtpTextField(
                    contentPadding: const EdgeInsets.symmetric(),
                    numberOfFields: 6,
                    borderColor: const Color(0xFF00488E),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      setState(() {
                        otp = code;
                      });
                    },
                    onSubmit: (String verifCode) {
                      setState(() {
                        otp = verifCode;
                      });
                    },
                  ),
                  VerticalSpacer(height: 35),
                  Center(
                    child: NeoPopTiltedButton(
                      isFloating: true,
                      onTapUp: () async {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: _verificationId,
                                  smsCode: otp);

                          _auth = FirebaseAuth.instance;

                          await _auth!.signInWithCredential(credential);

                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const GreetingScreen()));
                        } catch (e) {
                          print(e);
                        }
                      },
                      decoration: const NeoPopTiltedButtonDecoration(
                        color: primaryColor,
                        plunkColor: primaryColor,
                        shadowColor: Color.fromRGBO(36, 36, 36, 1),
                        showShimmer: true,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 130.0,
                          vertical: 15,
                        ),
                        child: Text('Verify OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        // if (loading) ...[
        //   const Center(
        //     child: CircularProgressIndicator(),
        //   )
        // ],
      ]),
    );
  }
}
