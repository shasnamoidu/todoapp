import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class SelectImage{
  XFile? image;
  Future<dynamic> getImage(_imagePicker)
  async
  {
    print('reached the repo');
    final Reference = FirebaseStorage.instance.ref().child(image!.name);
    final file = File(image!.path);
    await Reference.putFile(file);
    final imgPublicLink = await Reference.getDownloadURL();
    try{
    
      image = await _imagePicker.pickImage(source: ImageSource.gallery);
    }
    catch(e){
      rethrow;
    }
  }
}