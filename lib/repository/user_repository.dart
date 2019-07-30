import 'package:firebase/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository{
  final database = FirebaseDatabase.instance.reference();

  bool insertUser(User user){
    try{      
      user.key = database.child('user').push().key;      
      database.child('user').child(user.key).set(user.toJson());
    }
    on Exception {
      return false;
    }
    return true;
  }

  Future<DataSnapshot> getListData() async {
    return await database.child('user').once();
  }

  bool updateUser(User user){
    try{
      database.child('user').child(user.key).set(user.toJson());
    }
    on Exception {
      return false;
    }
    return true;
  }

  bool deleteUser(User user){
    try{
      database.child('user').child(user.key).remove();
    }
    on Exception{
      return false;
    }
    return true;
  }
}