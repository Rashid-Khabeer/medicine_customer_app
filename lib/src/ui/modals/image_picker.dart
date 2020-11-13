import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/constants.dart';

class ImagePickerDialog {
  ImagePickerDialog({
    BuildContext context,
    Function imgFromCamera,
    Function imgFromGallery,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Container(
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Add photo',
                  style:
                      k18BlackTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Use Camera'),
                leading: Icon(Icons.add_a_photo),
                onTap: imgFromCamera,
              ),
              ListTile(
                title: Text('Upload from gallery'),
                leading: Icon(Icons.photo_library),
                onTap: imgFromGallery,
              ),
            ],
          ),
        );
      },
    );
  }
}
