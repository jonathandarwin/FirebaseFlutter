import 'package:firebase/model/user.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

class InsertUpdateProvider extends ChangeNotifier{  

  // STATIC EVENT DATA
  static final int INSERT = 1;
  static final int UPDATE = 2;

  // ATTRIBUTE
  UserRepository userRepository = UserRepository();  
  User _user = User();  
  String _title = '';
  int _type = 0;  

  // SETTER
  User get user => _user;
  String get title => _title;
  int get type => _type;

  // GETTER
  set title(String title){
    this._title = title;
    notifyListeners();
  }


  void setInitData(User data){
    if(data == null){
      title = 'Insert';
      _type = INSERT;
      user.name = '';
      user.email = '';
    }
    else{
      title = 'Update';
      _type = UPDATE;
      user.name = data.name;
      user.email = data.email;    
      user.key = data.key;  
    }
  }

  InsertUpdateProvider(User user){
    setInitData(user);
  }

  String insertUser(){
    if(validateUser()){
      bool result = false;
      if(type == INSERT){
        result = userRepository.insertUser(user);
      }
      else{
        result = userRepository.updateUser(user);
      }

      if(result){
        return 'Success';
      }
      return 'Error. Please try again';
    }
    return 'Please input all the field';
  }

  bool validateUser(){
    if(user.email == null || user.email == "" ||
      user.name == null || user.name == ""){
        return false;
      }      
    return true;
  }

}