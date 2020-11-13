import 'dart:io';
import 'package:medicine_customer_app/src/ui/modals/dialogs.dart';
import 'package:medicine_customer_app/src/ui/modals/image_picker.dart';
import 'package:medicine_customer_app/src/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  final List<String> images;
  final Function(List<String> file) onChanged;

  ImageSelector({this.images, this.onChanged}) : assert(onChanged != null);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  // List<File> _images;
  List<String> _images;

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
                  onTap: () => print('Hello'),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(_images[index])),
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
    print('Gallery Function');
    Navigator.of(context).pop();
    // try {
    //   Navigator.of(context).pop();
    //   var result = await FilePicker.platform.pickFiles(
    //     type: FileType.image,
    //     allowMultiple: true,
    //   );
    //   List<String> selectedList = result.paths;
    //   setState(() {
    //     _images.addAll(selectedList);
    //     widget.onChanged(_images);
    //   });
    // } on PlatformException catch (e) {print(e);}
    // Navigator.of(context).pop();
    // final pickedImage =
    //     await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    // setState(() {
    //   _images.add(File(pickedImage.path));
    //   widget.onChanged(_images);
    // });
  }

  _imgFromCamera() async {
    print('Camera');
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
    // final pickedImage =
    //     await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    // setState(() {
    //   _images.add(pickedImage.path.toString());
    //   widget.onChanged(_images);
    // });
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
