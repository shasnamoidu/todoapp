import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/repo/imageRepo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String? imageurl;
  
  
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final CollectionReference signupRefer = FirebaseFirestore.instance.collection('SignUpCollection');
    
  Future<void> selectImage(
      // String profilePic,
      ) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        uploadImage();
      }
    });
  }

  //storage function

  uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference StorageReference = storage.ref().child('${DateTime.now()}');
    UploadTask uploadTask = StorageReference.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    imageurl = await taskSnapshot.ref.getDownloadURL();
    print('image uploaded');
    String userid = auth.currentUser!.uid;
    print('userid ->$userid');
    await signupRefer.doc(userid).update({
      'profilepic': imageurl
    });
  }

 

 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: signupRefer.doc(auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
                  return  Container(
        color: Color.fromARGB(255, 200, 210, 245),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      image != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 60,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data?['profilepic']),
                              radius: 60,
                            ),
                      Column(
                        children: [
                          Text('shasna'),
                          Text('shasna@gmail.com'),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: TextButton(
                      onPressed: () {
                        print('pick image function called');
                        selectImage();
                      },
                      child: const Text('Upload Image'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
        }
        return Container();
      },
      
    );
  }
}
