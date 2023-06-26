import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:for_rent/Providers/item_photo_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key});

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    var _photo = Provider.of<PhotoProvider>(context);
    return ClipRRect(
      child: _photo.PHOTO != null
          ? InkWell(
              onTap: () => _photo.imgFromGallery(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(
                  _photo.PHOTO!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 231, 231),
                  borderRadius: BorderRadius.circular(25)),
              width: 200,
              height: 200,
              child: IconButton(
                  onPressed: () async {
                    _photo.imgFromGallery();
                  },
                  icon: const Icon(Icons.add_a_photo_outlined))),
    );
  }
}
