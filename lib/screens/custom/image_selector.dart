import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final ValueChanged<PickedFile> onImageSelect;
  ImageSelector({this.onImageSelect});

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  PickedFile _image;

  _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallary'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    setState(() {
      this._image = image;
    });
    widget.onImageSelect(image);
  }

  _imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      this._image = image;
    });
    widget.onImageSelect(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PickedFile image = _showPicker(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        width: 150,
        height: 150,
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  File(_image.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                //width: 100,
                //height: 100,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey[800],
                  size: 50,
                ),
              ),
      ),
    );
  }
}
