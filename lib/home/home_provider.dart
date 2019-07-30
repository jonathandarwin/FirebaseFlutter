import 'package:firebase/model/user.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  List<User> _listUser = List<User>();
  UserRepository userRepository = UserRepository();
  bool _showLoading;

  get listUser => _listUser;
  set listUser(List<User> listUser){
    this._listUser = listUser;
    notifyListeners();
  }

  get showLoading => _showLoading;
  set showLoading(bool showLoading){
    this._showLoading = showLoading;
    notifyListeners();
  }
  
  Future<List<User>> getListData() async {        
    showLoading = true;
    DataSnapshot result = await userRepository.getListData();
    List<User> listTemp = List<User>();
    if(result.value != null){
      Iterable list = result.value.values;
      for(var data in list){
        listTemp.add(User.fromJson(data));
      }
      showLoading = false;
    }
    else{
      showLoading = false;
    }
    listUser = listTemp;  
    return listUser;  
  }

  // Future<List<User>> getListData() async {
  //   DataSnapshot result = await userRepository.getListData();
  //   List<User> listUser = List<User>();
  //   if(result.value != null){
  //     Iterable list = result.value.values;
  //     for(var data in list){
  //       listUser.add(User.fromJson(data));
  //     }
  //   }
  //   return listUser;
  // }

  bool deleteUser(User user) {
    return userRepository.deleteUser(user);
  }
}