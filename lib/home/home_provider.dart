import 'package:firebase/model/user.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  static const int SHOW_DATA = 1;
  static const int LOADING = 2;
  static const int NO_DATA = 3;

  List<User> _listUser = List<User>();
  UserRepository userRepository = UserRepository();
  bool _showLoading = true;
  bool _showNoData = false;

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

  get showNoData => _showNoData;
  set showNoData(bool showNoData){
    this._showNoData = showNoData;
    notifyListeners();
  }

  refresh(){
    notifyListeners();
  }
  
  Future<int> getListData() async {    
    // showLoading = true;
    // showNoData = false;
    DataSnapshot result = await userRepository.getListData();
    List<User> listTemp = List<User>();
    if(result.value != null){
      Iterable list = result.value.values;
      if(list.length > 0){
        for(var data in list){
          listTemp.add(User.fromJson(data));
        }        
      }  
      else{
        // showNoData = true;
        return NO_DATA;
      }         
    }
    else{
      return NO_DATA;
    }
    // showLoading = false;
    _listUser = listTemp;    
    return SHOW_DATA;
  }

  bool deleteUser(User user) {
    return userRepository.deleteUser(user);
  }
}