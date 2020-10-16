import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {

  final String uid;
  StorageService({this.uid});

  final _storage = FirebaseStorage.instance;

  StorageReference _getRoomStorageReference() {
    return _storage.ref().child(this.uid).child("room");
  }
  
  Future<String> uploadRoomImage(File file) async {
    String fileName = basename(file.path);
    print("saving file : [ "+fileName+" ]");
    StorageUploadTask uploadTask = _getRoomStorageReference().child(fileName).putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    print("saved file with url : "+ url);
    return url;
  }
}