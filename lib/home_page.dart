import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conclave/constants/constants.dart';
import 'package:conclave/custom/spacers.dart';
import 'package:conclave/manage_quizes.dart';
import 'package:conclave/models/feature_model.dart';
import 'package:conclave/quiz_home.dart';
import 'package:conclave/services/storage_services.dart';
import 'package:conclave/web_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();

  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final pageUrlController = TextEditingController();

  bool admin = false;
  String name = "NA";

  List<FeatureModel> featues = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> quizes = [];

  adminCheck() async {
    print("rannn27");
    final pf = await LocalStorageService().loadData('Pfnum') ?? '';

    final docRef =
        FirebaseFirestore.instance.collection('conclaveData').doc('data');

    try {
      print("rannn34");
      final doc = await docRef.get();
      if (!doc.exists) {
        return false;
      }

      final data = doc.data();
      if (data == null || data['admins'] == null) {
        return false;
      }

      print(_checkNumberInAdmins(data['admins'], pf));

      setState(() {
        admin = _checkNumberInAdmins(data['admins'], pf);
      });
    } catch (error) {
      debugPrint(error.toString());
    }

    return true;
  }

  bool _checkNumberInAdmins(List admins, String yourNumber) {
    return admins.any((admin) => admin == yourNumber);
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

        setState(() {
          name = userData['Name'];
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    // return null; // Indicate name not found
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Feature'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Content won't overflow
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: InputDecoration(
                  label: const Text(
                    "title",
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
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
              VerticalSpacer(height: 15),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: imageUrlController,
                decoration: InputDecoration(
                  label: const Text(
                    "Image url",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  hintText: "enter Image url",
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
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
              VerticalSpacer(height: 15),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: pageUrlController,
                decoration: InputDecoration(
                  label: const Text(
                    "Feature url",
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
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                // print(title);
                addViewToFeatures();

                // _sendDataToApi(title, imageUrl, pageUrl);
                Navigator.pop(context); // Close the popup after sending data
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

// Future<List<QueryDocumentSnapshot>>
  getDocuments() async {
    final collectionRef = FirebaseFirestore.instance.collection('conclaveQuiz');
    final querySnapshot = await collectionRef.get();
    final documents = querySnapshot.docs;
    setState(() {
      quizes = documents;
    });
    print(documents[0]['questions'][0]['question'] + "--------->");
  }

  getTitles() async {
    final docRef =
        FirebaseFirestore.instance.collection('conclaveData').doc('Features');
    final doc = await docRef.get();
    if (!doc.exists) {
      return []; // Document doesn't exist, return empty list
    }

    final data = doc.data();
    if (data == null || data['webViews'] == null) {
      return []; // No views array in the document
    }

    // Get the views list from the data
    final views = data['webViews'] as List;

    // Extract titles from each view
    final List<FeatureModel> _features = views
        .map((view) => FeatureModel.fromJson(view as Map<String, dynamic>))
        .toList();

    print("------------------>${_features[0].title}");

    setState(() {
      featues = _features;
    });

    // return features;
  }

  Future<void> addViewToFeatures() async {
    final docRef =
        FirebaseFirestore.instance.collection('conclaveData').doc('Features');
    final title = titleController.text;
    final imageUrl = imageUrlController.text;
    final pageUrl = pageUrlController.text;
    // Create the map for the view
    final view = {'title': title, 'bgUrl': imageUrl, 'url': pageUrl};

    print("--------------->");

    // Update the document with the new view
    await docRef.update({
      'webViews': FieldValue.arrayUnion([view]), // Add the view to the array
    });
    titleController.clear();
    imageUrlController.clear();
    pageUrlController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showNameByNumber();
    adminCheck();

    getTitles();

    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
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
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              stretch: false,
              automaticallyImplyLeading: false,
              onStretchTrigger: () async {
                // Triggers when stretching
              },
              // [stretchTriggerOffset] describes the amount of overscroll that must occur
              // to trigger [onStretchTrigger]
              //
              // Setting [stretchTriggerOffset] to a value of 300.0 will trigger
              // [onStretchTrigger] when the user has overscrolled by 300.0 pixels.
              stretchTriggerOffset: 300.0,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                // collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/Rectangle 4965.png',
                              height: 40,
                            ),
                          ),
                          HorizontalSpacer(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                name,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 77, 77, 77),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notification_add,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Your desired column configuration
                  children: [
                    // Add your widgets here

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(2.0)),
                          ),
                          width: 40.0,
                          height: 2.0,
                          margin: const EdgeInsets.only(bottom: 25.0, top: 25),
                        ),
                      ],
                    ),
                    VerticalSpacer(height: 20),
                    // const SizedBox(
                    //   height: 180,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: Container(
                    //     width: mq.size.width,
                    //     height: 100,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(20),
                    //       // border: Border.all(color: Color.fromRGBO(r, g, b, opacity)),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.2),
                    //           spreadRadius: 1,
                    //           blurRadius: 5,
                    //           offset: const Offset(
                    //               1, 1), // changes position of shadow
                    //         ),
                    //       ],
                    //     ),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(20.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,

                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        // onPageChanged: (index, reason) {
                        //   setState(() {
                        //     currentIndex = index;
                        //     print(currentIndex);
                        //   });
                        // },
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/greeting_bg.png',
                            width: mq.size.width,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/greeting_bg.png',
                            width: mq.size.width,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/greeting_bg.png',
                            width: mq.size.width,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Events'),
                        ),
                        if (admin) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ManageQuizes(
                                        quizes: quizes,
                                      )));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text('Manage Quiz'),
                            ),
                          ),
                        ],
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 140.0, // Set a fixed height for the container
                        child: ListView.builder(
                          scrollDirection:
                              Axis.horizontal, // Set horizontal scrolling
                          itemCount: quizes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: QuizHome(
                                          quiz: quizes[index].id,
                                        )));
                              },
                              child: Container(
                                width: 200.0, // Set a width for each item
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0), // Add spacing
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOyDXRMiMSsg6Ct9HbUmbKatB5QekUVW8VOQ&s'),
          fit: BoxFit.fill,
        ),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(quizes[index].id),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Explore'),
                        ),
                        if (admin) ...[
                          GestureDetector(
                            onTap: () {
                              _showPopup();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text('Add Feature'),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 140.0, // Set a fixed height for the container
                        child: ListView.builder(
                          scrollDirection:
                              Axis.horizontal, // Set horizontal scrolling
                          itemCount: featues.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: WebPage(
                                          url: featues[index].url!,
                                          title: featues[index].title!,
                                        )));
                              },
                              child: Container(
                                
                                width: 200.0, // Set a width for each item
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0), // Add spacing
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJIVOzo6-fuhkdegiKAPXZFbnoSxozdMehiw&s'),
          fit: BoxFit.fill,
        ),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(featues[index].title!,style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54
                                ),),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    VerticalSpacer(height: 70)
                  ],
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         color: index.isOdd ? Colors.white : Colors.black12,
            //         height: 100.0,
            //         child: Center(
            //           child: Text('$index',
            //               textScaler: const TextScaler.linear(5.0)),
            //         ),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // ),
          ],
        ),
      ]),
    );
  }
}
