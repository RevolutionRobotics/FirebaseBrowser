import 'dart:async';
import 'dart:html';

import 'package:firebase/firebase.dart';

class Firebase {

  static final Firebase _singleton = Firebase._internal(); 
  
  static Database _database = database();
  static Storage _storage = storage();

  factory Firebase() {
    initializeApp(
      apiKey: 'AIzaSyCHoUYE86LbyoKzP7W0t1znmLuyEKTyGmo',
      authDomain: 'revolutionroboticsdev.firebaseapp.com',
      databaseURL: 'https://revolutionroboticsdev.firebaseio.com',
      projectId: 'revolutionroboticsdev',
      storageBucket: 'revolutionroboticsdev.appspot.com'
    );

    return _singleton;
  }

  void listen(String reference, Function listener) {
    _database.ref(reference).onValue.listen(listener);
  }

  void once(String reference, Function callback) {
    _database.ref(reference).once('value').then((e) => callback(e));
  }

  void update(String reference, dynamic value) {
    _database.ref(reference).update(value);
  }

  Future<Uri> getImageUrl(String gsUrl) async {
    return await _storage.refFromURL(gsUrl).getDownloadURL();
  }

  Future<String> updateImage(String reference, File image) async {
    String extension = image.name.contains('.') ? '.${image.name.split('.').last}' : '';
    String path = '$reference/coverImage$extension';
    
    await _storage.ref(path).put(image).future;
    return _storage.ref(path).toString();
  }

  Firebase._internal();
}
