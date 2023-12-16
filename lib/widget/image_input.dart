import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPicked});
final void Function (File image) onPicked;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void takepicture() async {
    final imagepicker = ImagePicker();
    final pickedimage =
        await imagepicker.pickImage(source:  ImageSource.camera, maxWidth: 600);
    if (pickedimage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedimage.path);
    });

   widget.onPicked(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).highlightColor, width: 5),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      height: 250,
      child: selectedImage == null
          ? TextButton.icon(
              onPressed: () {
                takepicture();
              },
              icon: Icon(Icons.camera_alt),
              label: Text('Take picture'),
            )
          : GestureDetector(
        onTap: takepicture,
            child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
          ),
    );
  }
}
