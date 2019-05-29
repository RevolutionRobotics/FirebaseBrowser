import firebase from 'firebase'

var firebaseConfig = {
    apiKey: "AIzaSyCHoUYE86LbyoKzP7W0t1znmLuyEKTyGmo",
    authDomain: "revolutionroboticsdev.firebaseapp.com",
    databaseURL: "https://revolutionroboticsdev.firebaseio.com",
    projectId: "revolutionroboticsdev",
    storageBucket: "revolutionroboticsdev.appspot.com",
    messagingSenderId: "54672154034",
    appId: "1:54672154034:web:97345d105e653f34"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);

  export default firebase;