import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_clone/widgets/took_photo.dart';
import 'package:my_clone/widgets/took_video.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isFlashTapped = false;
  bool isRecording = false;
  int selectedCameraIndex = 0;
  FlashMode _currentFlashMode = FlashMode.off;
  double transform = 0.0;
  bool _isContainerVisible = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera(selectedCameraIndex);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _initializeCamera(int cameraIndex) {
    _cameraController =
        CameraController(widget.cameras[cameraIndex], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  void _flipCamera() {
    if (widget.cameras.length > 1) {
      setState(() {
        selectedCameraIndex = (selectedCameraIndex + 1) % widget.cameras.length;
        _cameraController.dispose();
        _initializeCamera(selectedCameraIndex);
      });
    } else {
      // print('No secondary camera found');
      debugPrint('No secondary camera found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            top: 40,
            right: 5,
            child: IconButton(
              onPressed: () async {
                setState(() {
                  switch (_currentFlashMode) {
                    case FlashMode.off:
                      _currentFlashMode = FlashMode.always;
                      break;
                    case FlashMode.always:
                      _currentFlashMode = FlashMode.auto;
                      break;
                    default:
                      _currentFlashMode = FlashMode.off;
                      break;
                  }
                });
                try {
                  await _cameraController.setFlashMode(
                    _currentFlashMode,
                  );
                } catch (e) {
                  debugPrint('$e');
                }
              },
              icon: Icon(
                _currentFlashMode == FlashMode.off
                    ? Icons.flash_off
                    : _currentFlashMode == FlashMode.always
                        ? Icons.flash_on
                        : Icons.flash_auto,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 5,
            child: IconButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
                size: 35,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black.withOpacity(0.7),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          //handle gallery function
                        },
                        icon: const Icon(
                          Icons.photo_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle capture photo
                          if (!isRecording) {
                            _takePhoto(context);
                          }
                        },
                        onLongPress: () async {
                          try {
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          } catch (e) {
                            // print('Error starting video recording: $e');
                            debugPrint('Error starting video recording: $e');
                          }
                        },
                        onLongPressUp: () async {
                          try {
                            final XFile videoFile =
                                await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            if (videoFile.path.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) =>
                                      TookVideo(path: videoFile.path),
                                ),
                              );
                            } else {
                              debugPrint('Video file path is empty!');
                            }
                          } catch (e) {
                            debugPrint('Error stopping video recording: $e');
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: Center(
                            child: isRecording
                                ? const Icon(
                                    Icons.radio_button_on_outlined,
                                    color: Colors.red,
                                    size: 40,
                                  )
                                : const Icon(
                                    Icons.panorama_fish_eye_rounded,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            transform += pi;
                            _flipCamera();
                          });
                        },
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            // to see the rotation of camera just change that icon or use svg file insted
                            Icons.flip_camera_android_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Hold to record, tap to capture",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if any error occured then delete the below code upto the last child of stack
          Positioned(
            // left: 195,
            left: 105,
            right: 100,
            // bottom: 125,
            bottom: _isContainerVisible ? 195 : 125,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isContainerVisible = !_isContainerVisible;
                });

                // _container(context);
              },
              child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            ),
          ),
          if (_isContainerVisible)
            Positioned(
              bottom: 128,
              child: Container(
                height: 70,
                color: Colors.black.withOpacity(0.7), // Container styling
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(10, (index) {
                      String imageUrl = "https://via.placeholder.com/150";
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            imageUrl,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _takePhoto(BuildContext ctx) async {
    try {
      final directory = await getTemporaryDirectory();
      final path = join(directory.path, '${DateTime.now()}.jpg');
      debugPrint('path is: $path');
      XFile picture = await _cameraController.takePicture();
      final imagePath = picture.path;
      debugPrint('pciture path is: ${picture.path}');
      Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (builder) => TookPhoto(
                  path: imagePath,
                )),
      );
    } catch (e) {
      debugPrintStack(label: 'Error taking photo: $e');
      // print('Error taking photo: $e');
    }
  }
}
