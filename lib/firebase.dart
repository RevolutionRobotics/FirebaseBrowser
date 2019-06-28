import 'package:firebase/firebase.dart';

class Firebase {

  static final Firebase _singleton = Firebase._internal(); 
  
  static Database _database;
  static Storage _storage;

  factory Firebase() {
    initializeApp(
      apiKey: 'AIzaSyCHoUYE86LbyoKzP7W0t1znmLuyEKTyGmo',
      authDomain: 'revolutionroboticsdev.firebaseapp.com',
      databaseURL: 'https://revolutionroboticsdev.firebaseio.com',
      projectId: 'revolutionroboticsdev',
      storageBucket: 'revolutionroboticsdev.appspot.com'
    );

    _database = database();
    _storage = storage();

    return _singleton;
  }

  void listen(String reference, Function listener) {
    DatabaseReference ref = _database.ref(reference);
    ref.onValue.listen(listener);
  }

  void once(String reference, Function callback) {
    DatabaseReference ref = _database.ref(reference);
    ref.once('value').then((e) => callback(e));
  }

  void getImageUrl(String gsUrl, Function callback) {
    final StorageReference ref = _storage.refFromURL(gsUrl);
    ref.getDownloadURL().then((value) {
      callback(value.toString());
    });
  }

  void update(String reference, dynamic value) {
    _database.ref(reference).update(value);
  }

  Firebase._internal();
}
