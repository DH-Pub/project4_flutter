import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/models/user.dart';

class UserImage extends StatefulWidget {
  final XFile? image;
  final Function getImage;
  final User user;
  const UserImage({super.key, required this.user, required this.getImage, required this.image});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  void chooseImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose an image'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.getImage(ImageSource.gallery);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  //if user click this button. user can upload image from camera
                  onPressed: () {
                    Navigator.pop(context);
                    widget.getImage(ImageSource.camera);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'From Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: widget.image != null
              ? Image.file(
                  File(widget.image!.path),
                )
              : widget.user.pic != ""
                  ? Image.network("${API_CONSTANTS.user}/image/${widget.user.pic}")
                  : Center(
                      child: Text(
                        widget.user.username == "" ? "" : widget.user.username[0],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
        ),
      ),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          chooseImage();
        },
        child: const Text(
          'Upload Photo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
