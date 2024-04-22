import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/otp_verifcation.dart';
import 'package:conclave/services/storage_services.dart';
import 'package:conclave/utils/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neopop/neopop.dart';
import 'package:page_transition/page_transition.dart';

import 'constants/constants.dart';
import 'custom/spacers.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({super.key, required this.title});

  final String title;

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  bool isFirstTime = false;
  List<dynamic> datas = [];
  bool loading = false;
  TextEditingController upiCtrl = TextEditingController();
  FirebaseFirestore? db;

  @override
  void initState() {
    super.initState();
    initialiseFirestore();
  }

  initialiseFirestore() async {
    if (!isFirstTime) {
      setState(() {
        loading = true;
        db = FirebaseFirestore.instance;
      });
      isFirstTime = true;

      // getList();
    }
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();

  Future<String?> getUserNameByNumber(String phoneNumber) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('employee_details_v2')
          .where('MobileNo', isEqualTo: phoneController.text)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        final userData = docSnapshot.data();
        return userData['Pfnum'];
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return null; // Indicate name not found
  }

  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                children: [
                  VerticalSpacer(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      label: const Text(
                        "Mobile number",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      hintText: "enter your 10 digit mobile number",
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
                  // VerticalSpacer(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: employeeIdController,
                    decoration: InputDecoration(
                      label: const Text(
                        "Employee Id",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      hintText: "enter your Employee Id",
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

                  // FederalBankTextField(
                  //     inputType: TextInputType.number,
                  //     controller: phoneController,
                  //     labelText: "Mobile number",
                  //     hintText: "enter your 10 digit mobile number"),

                  // FederalBankTextField(
                  //     inputType: TextInputType.emailAddress,
                  //     controller: employeeIdController,
                  //     labelText: "Employee Id",
                  //     hintText: "enter your Employee Id"),
                  VerticalSpacer(height: 35),
                  NeoPopTiltedButton(
                    isFloating: true,
                    onTapUp: () async {
                      final test =
                          await getUserNameByNumber(phoneController.text);

                      if (test == employeeIdController.text) {
                        LocalStorageService().saveData('Pfnum', test!);
                        // final name =
                        //     await getNameByNumber(phoneController.text);
                        // print("----------->${name!}");

                        // Random().showAutoDismissingPopup(context, Text(name));

                        const snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: Text("Success!"),
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);

                        LocalStorageService()
                            .saveData('mobNo', phoneController.text);
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const OtpVericationScreen()));
                      } else {
                        const snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: Text("Invalid Credentials"),
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
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
                      child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  // CustomButton(text: 'Verify', onTap: () async {})
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
