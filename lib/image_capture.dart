import 'dart:io';

import 'package:camera/camera.dart';
import 'package:conclave/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  CameraController? camCtrl;
  bool loading = false;
  late TabController tabCtrl;

  int _currentIndex = 0; // Track the currently displayed container
  Future<void> _takePicture() async {
    debugPrint('line 26');
    if (camCtrl?.value.isRecordingVideo == true) {
      return;
    }

    try {
      debugPrint('line 32');
      setState(() {
        loading = true;
      });

      final XFile image = await camCtrl!.takePicture();

      debugPrint('line 39');

      await _uploadImageToFirebase(image).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image Captured')),
        );

        debugPrint('---------------->complete');
        setState(() {
          loading = false;
        });
      });

      // Save the image to storage
      // await _saveImage(image.path);

      debugPrint('Image captured and saved to ${image.path}');
    } on CameraException catch (e) {
      // Handle capture errors
      debugPrint('Error capturing image: $e');
    }
  }

  Future<void> _uploadImageToFirebase(XFile image) async {
    // Create a unique file name with timestamp
    final now = "conclave$_currentIndex";
    final fileName = '$now.jpg';

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('conclaveImages/26123/$fileName');
      final uploadTask = storageRef.putFile(File(image.path));

      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();

      debugPrint('Image uploaded successfully to $url');
    } on FirebaseException catch (e) {
      // Handle upload errors
      debugPrint('Error uploading image: ${e.code} - ${e.message}');
    }
  }

  Future<void> _saveImage(String imagePath) async {
    // final directory = await getApplicationDocumentsDirectory();
    // final now = DateTime.now().second;
    final now = "conclave$_currentIndex";
    final fileName = '$now.jpg';
    final newPath = '/storage/emulated/0/DCIM/$fileName';
    await File(imagePath).copy(newPath);
  }

  void _changeContainer() {
    print("$_currentIndex------------>");
    debugPrint('line 93');
    if (_currentIndex < 4) {
      _takePicture();
      print(_currentIndex);
      setState(() {
        _currentIndex++;
        // _currentIndex = (_currentIndex + 1) % 4; // Cycle through containers
      });
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: const HomePage()));
    }
  }

  initCam() async {
    setState(() {
      loading = true;
    });
    final i = await getNumberOfImages();

    if (i == 4) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: const HomePage()));
      setState(() {
        loading = false;
      });
    } else {
      print("---------------->$i");

      final cameras = await availableCameras();
      camCtrl = CameraController(cameras[1], ResolutionPreset.max);
      camCtrl!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
      setState(() {
        loading = false;
      });
    }
  }

  // Future<void> _initializeCameras() async {
  //   final cameras = await availableCameras();

  //   // Validate camera availability
  //   if (cameras.length < 4) {
  //     print('Insufficient cameras found (minimum 4 required).');
  //     return;
  //   }

  //   _cameraControllers = List.generate(
  //       4, (index) => CameraController(cameras[index], ResolutionPreset.max));
  //   _cameraPreviews.clear(); // Empty existing previews

  //   for (final controller in _cameraControllers) {
  //     await controller.initialize();
  //     _cameraPreviews.add(CameraPreview(controller));
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  void _showWelcomePopup(BuildContext context) {
    print('rannnnnnn');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome to my App!'),
        content: const Text('This is a one-time welcome message.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ); // Update flag after showing
  }

  Future<int> getNumberOfImages() async {
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('conclaveImages/26123');

    try {
      final result = await reference.listAll();
      final items = result.items;
      print(items.length);
      return items.length;
    } catch (error) {
      print('Error getting files: $error');
      return 0; // Or handle error differently
    }
  }

  Future<void> _loadIsFirstLoad(BuildContext context) async {
    print('rannnnnnn');
    _showWelcomePopup(context);
  }

  @override
  void initState() {
    super.initState();

    // _initializeCameras();
    initCam();
    _loadIsFirstLoad(context);
    // getNumberOfImages();
    // print(_cameraPreviews.length);
  }

  @override
  void dispose() {
    camCtrl!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // openPopup(context);
    // final mq = MediaQuery.of(context).size;

    // _loadIsFirstLoad(context);

    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pop(context);
    // });

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              Column(
                children: [
                  // Text('capture images $_currentIndex'),

                  // _cameraPreviews[
                  //     _currentIndex], // Display the currently selected container
                  CameraPreview(camCtrl!),
                  const SizedBox(
                      height: 20.0), // Add spacing between container and button
                  // ElevatedButton(
                  //   onPressed: _changeContainer,
                  //   child: const Text('capture'),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Container(
                            // Wrap CircleAvatar with Container
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Colors.white, // Inner circle background color
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Colors
                                  .transparent, // Make inner circle transparent
                              radius: 35.0, // Adjust radius for desired size
                            ),
                          ),
                          Text(_currentIndex.toString())
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          print('line 283');
                          _changeContainer();
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 84,
                              height: 84,
                              child: const CircleAvatar(
                                backgroundColor:
                                    Colors.white, // Outer circle color
                                radius: 100.0, // Adjust radius for desired size
                              ),
                            ),
                            Positioned(
                              top: 5.0, // Adjust offset for positioning
                              left: 5.0, // Adjust offset for positioning
                              child: Container(
                                // Wrap CircleAvatar with Container
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .white, // Inner circle background color
                                  border: Border.all(
                                    color: Colors.black, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors
                                      .transparent, // Make inner circle transparent
                                  radius:
                                      35.0, // Adjust radius for desired size
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // Wrap CircleAvatar with Container
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // Inner circle background color
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors
                              .transparent, // Make inner circle transparent
                          radius: 35.0, // Adjust radius for desired size
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.black38,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                ),
              ),
              if (loading) ...[
                const Center(child: CircularProgressIndicator())
              ],
            ],
          ),
        ),
      ),
    );
  }
}
