class User{
  String _name;
  String _email;
  String _key;

  User();

  User.setData(
    this._name,
    this._email,
    this._key
  );  

  User.fromJson(var value){
    this._email = value['email'];
    this._name = value['name'];   
    this._key = value['key'];
  }  

  Map<String, dynamic> toJson() => {
    'email' : _email,
    'name' : _name,
    'key' : _key
  };

  String get name => _name;
  String get email => _email;
  String get key => _key;

  set email(String email) => this._email = email;
  set name(String name) => this._name = name;
  set key(String key) => this._key = key;
}