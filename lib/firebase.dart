import 'package:firebase/firebase.dart';

class Firebase {

  static final Firebase _singleton = new Firebase._internal();
  static Database _database;

  factory Firebase() {
    initializeApp(
      apiKey: 'AIzaSyCHoUYE86LbyoKzP7W0t1znmLuyEKTyGmo',
      authDomain: 'revolutionroboticsdev.firebaseapp.com',
      databaseURL: 'https://revolutionroboticsdev.firebaseio.com',
      projectId: 'revolutionroboticsdev',
      storageBucket: 'revolutionroboticsdev.appspot.com'
    );

    _database = database();
    return _singleton;
  }

  void listen(String reference, Function listener) {
    DatabaseReference ref = _database.ref(reference);
    ref.onValue.listen(listener);
  }

  Firebase._internal();
}
