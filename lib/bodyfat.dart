import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:kickweight/main.dart';

class BodyFatCalculator extends StatefulWidget {
  final String weightofuser;
  final String heightofuser;

  const BodyFatCalculator({
    Key? key,
    required this.weightofuser,
    required this.heightofuser,
  }) : super(key: key);

  @override
  _BodyFatCalculatorState createState() => _BodyFatCalculatorState();
}

class _BodyFatCalculatorState extends State<BodyFatCalculator> {
  late CameraController _cameraController;
  late List<CameraDescription> _availableCameras;
  File? _image;
  double? _bodyFatPercentage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    setState(() {
      _availableCameras = cameras;
      _cameraController = CameraController(
        _availableCameras[0],
        ResolutionPreset.medium,
      );
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  Future<void> _captureImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _bodyFatPercentage = null;
      });
      await _calculateBodyFatPercentage();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsScreen(
                  weightofuser: widget.weightofuser,
                  heightofuser: widget.heightofuser,
                  year: '',
                )),
      );
    }
  }

  Future<void> _calculateBodyFatPercentage() async {
    await Future.delayed(const Duration(seconds: 2));
    final randomPercentage = 20.5; // Replace with the calculated percentage
    setState(() {
      _bodyFatPercentage = randomPercentage;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Fat Calculator'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    width: 200,
                    height: 200,
                  )
                else
                  const Text('No image selected'),
                const SizedBox(height: 16),
                if (_bodyFatPercentage != null && _bodyFatPercentage != 0.0)
                  Text(
                    'Body Fat Percentage: ${_bodyFatPercentage!.toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 18),
                  )
                else
                  const Text(
                    'Capture an image to calculate body fat percentage.',
                    style: TextStyle(fontSize: 18),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _captureImageFromCamera,
                  child: const Text('Capture Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
