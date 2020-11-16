import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/image_picker.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  final List<File> images;
  final Function(List<File> file) onChanged;

  ImageSelector({this.images, this.onChanged}) : assert(onChanged != null);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  ImagePicker _imagePicker = ImagePicker();

  List<File> _images;

  @override
  void initState() {
    super.initState();
    _images = widget.images ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ButtonWidget(
            text: 'Upload photo',
            height: 30.0,
            color: Colors.orange,
            onPressed: () => ImagePickerDialog(
                context: context,
                imgFromCamera: _imgFromCamera,
                imgFromGallery: _imgFromGallery),
          ),
        ),
        if (_images?.isNotEmpty ?? null)
          Container(
            height: 300.0,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _deleteDialog(index),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  _imgFromGallery() async {
    Navigator.of(context).pop();
    final pickedImage = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _images.add(File(pickedImage.path));
      widget.onChanged(_images);
    });
  }

  _imgFromCamera() async {
    Navigator.of(context).pop();
    final pickedImage = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _images.add(File(pickedImage.path));
      widget.onChanged(_images);
    });
  }

  _deleteDialog(index) {
    ConfirmDialog(
      context: context,
      content: 'Do you want to delete the selected photo?',
      function: () {
        _delete(index);
      },
    ).show();
  }

  _delete(index) {
    setState(() => _images.removeAt(index));
    Navigator.of(context).pop();
  }
}
