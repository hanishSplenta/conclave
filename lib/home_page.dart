import 'package:carousel_slider/carousel_slider.dart';
import 'package:conclave/custom/spacers.dart';
import 'package:conclave/quiz_home.dart';
import 'package:conclave/web_view_page.dart';
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
  bool _stretch = true;
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
              stretch: _stretch,
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                                'Hanish Koushik',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
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
                    const SizedBox(
                      height: 180,
                    ),
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

                    const Row(
                      children: [],
                    ),

                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Events'),
                    ),

                    // GridView.count(
                    //   crossAxisCount: 2, // Set the number of columns to 2
                    //   mainAxisSpacing:
                    //       10.0, // Add spacing between rows (optional)
                    //   crossAxisSpacing: 5.0,
                    //   children: [],
                    // ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const QuizHome()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: mq.size.width,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[Text('Quiz')],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: WebPage(
                                  url:
                                      "https://gemini.google.com/app/9d40c2e2e0beb858",
                                  title: 'Web view',
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          // width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[Text("webview sample")],
                            ),
                          ),
                        ),
                      ),
                    ),
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
