import 'package:firebase/model/user.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  List<User> _listUser = List<User>();
  UserRepository userRepository = UserRepository();

  get listUser => _listUser;
  set listUser(List<User> listUser) => this._listUser = listUser;
  

  Future<List<User>> getListData() async {
    DataSnapshot result = await userRepository.getListData();
    List<User> listUser = List<User>();
    if(result.value != null){
      Iterable list = result.value.values;
      for(var data in list){
        listUser.add(User.fromJson(data));
      }
    }
    return listUser;
  }

  bool deleteUser(User user) {
    return userRepository.deleteUser(user);
  }
}