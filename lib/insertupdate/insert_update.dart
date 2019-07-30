import 'package:firebase/insertupdate/insert_update_provider.dart';
import 'package:firebase/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InsertUpdateLayout extends StatelessWidget{  
  final User user;
  InsertUpdateLayout(this.user);
  
  @override
  Widget build(BuildContext context){

    return ChangeNotifierProvider(
      builder : (context) => InsertUpdateProvider(user),
      child: Scaffold(
      appBar: AppBar(
          title: Text('Insert Update'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Title(),
              TextFieldEmail(),
              TextFieldName(),
              ButtonSave()
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget{
  @override
  Widget build(BuildContext context){    
    return Consumer<InsertUpdateProvider>(
      builder: (context, provider, _) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Text(
            provider.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0
            ),
          ),
        ),
      ),      
    );
  }  
}

class TextFieldEmail extends StatelessWidget{

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    final InsertUpdateProvider _provider = Provider.of<InsertUpdateProvider>(context);
    emailController.text = _provider.user.email;

    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
      child: TextField(        
        readOnly: _provider.type == InsertUpdateProvider.INSERT ? false : true,
        controller: emailController,        
        enabled: _provider.type == InsertUpdateProvider.INSERT ? true : false,
        onChanged: (text) => _provider.user.email = text,
        decoration: InputDecoration(
          labelText: "Email"          
        ),
      ),
    );
  }
}

class TextFieldName extends StatelessWidget{

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context){
    final InsertUpdateProvider _provider = Provider.of<InsertUpdateProvider>(context);
    nameController.text = _provider.user.name;

    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
      child: TextField(        
        controller: nameController,
        onChanged: (text) => _provider.user.name = text,
        decoration: InputDecoration(
          labelText: "Name"
        ),
      ),
    );
  }
}

class ButtonSave extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final InsertUpdateProvider _provider = Provider.of<InsertUpdateProvider>(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () => insertUser(context, _provider),
        child: Text('Save'),
      ),
    );
  }

  void insertUser(BuildContext context, InsertUpdateProvider provider){
    String message = provider.insertUser();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      )
    );
    if(message == 'Success'){
      Navigator.pop(context);
    }    
  }
}