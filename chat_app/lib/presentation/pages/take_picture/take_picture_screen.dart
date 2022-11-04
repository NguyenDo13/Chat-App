import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:chat_app/presentation/pages/take_picture/display_picture_screen.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final List<CameraDescription> cameras;
  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.cameras,
  });

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        child: Stack(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: lightGreyDarkMode.withOpacity(0.5),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width14 * 2,
                    ),
                    InkWell(
                      onTap: () async {
                        await _takePhoto();
                      },
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: lightGreyDarkMode.withOpacity(0.5),
                        child: Container(
                          margin: EdgeInsets.all(Dimensions.height6),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.double40),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width14 * 2,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: lightGreyDarkMode.withOpacity(0.5),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: _cameraSwitch,
                        icon: const Icon(Icons.cameraswitch_sharp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _takePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      if (!mounted) return;

      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: image.path),
        ),
      );

      if (!mounted) return;

      if (result != null) {
        Navigator.pop(context, result);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future _cameraSwitch() async {
    final CameraDescription cameraDescription =
        (_cameraController.description == widget.cameras[0])
            ? widget.cameras[1]
            : widget.cameras[0];
    if (_cameraController != null) {
      await _cameraController.dispose();
    }
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    _cameraController.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController.value.hasError) {
        _showSnackBar(
            'Camera error ${_cameraController.value.errorDescription}');
      }
    });
    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  _showCameraException(CameraException e) {
    logError(e.code, e.description!);
    _showSnackBar('Error: ${e.code}\n${e.description!}');
  }

  logError(String code, String message) {
    log('Error: $code\nError Message: $message');
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: lightGreyDarkMode,
        content: SizedBox(
          height: 32,
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: redAccent,
                  ),
            ),
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
