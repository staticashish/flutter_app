import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {

  final String uid;
  StorageService({this.uid});

  final _storage = FirebaseStorage.instance;

  Reference _getRoomStorageReference() {
    return _storage.ref().child(this.uid).child("room");
  }

  Reference _getCabinetStorageReference() {
    return _storage.ref().child(this.uid).child("cabinet");
  }

  Future<String> uploadImage(File file) async {
    final String fileName = basename(file.path);
    print("saving file : [ "+fileName+" ]");
    final UploadTask uploadTask = _getRoomStorageReference().child(fileName).putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String url = await taskSnapshot.ref.getDownloadURL();
    print("saved file with url : "+ url);
    return url;
  }

  Future<void> deleteImage(String imageName) async {
    print("deleting file : [ "+imageName+" ]");
    _getRoomStorageReference().child(imageName).delete();
  }
}