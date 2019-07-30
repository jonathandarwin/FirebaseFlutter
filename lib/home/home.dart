import 'package:firebase/home/home_provider.dart';
import 'package:firebase/insertupdate/insert_update.dart';
import 'package:firebase/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => HomeProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),        
          ),
          body: ListData(),
          floatingActionButton: ButtonAdd(),
        ),
      )    
    );
  }
}

class ListData extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    HomeProvider _provider = Provider.of<HomeProvider>(context);    

    return FutureBuilder(
      future: _provider.getListData(),            
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('Loading...'),
          );
        }  
        else{          
          List<User> listUser = snapshot.data;

          if(listUser.length == 0){
            return Center(
              child: Text('No Data'),
            );
          }

          return ListItem(listUser);
        }        
      },
    ); 
  }
}

class ListItem extends StatelessWidget{
  final List<User> listUser;
  ListItem(this.listUser);

  @override
  Widget build(BuildContext context){
    return ListView.separated(
              separatorBuilder: (context, i) => Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            itemCount: listUser.length,
            itemBuilder: (context, i){
              return GestureDetector(
                onTap: () => ButtonAdd.gotoInsertUpdate(context, listUser[i]),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(                    
                    children: <Widget>[
                      // DATA 
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[                  
                            TextName(listUser[i].name),
                            TextEmail(listUser[i].email)
                          ],
                        ),
                      ),
                      // DELETE
                      Expanded(
                        flex: 1,
                        child: IconDelete(listUser[i]),
                      )
                    ],
                  )
                ),
              );
            },
          );
  }
}

class TextEmail extends StatelessWidget{
  final String email;

  TextEmail(this.email);

  @override
  Widget build(BuildContext context){
    return Container(      
      child: Text(
        email
      ),
    );
  }
}

class TextName extends StatelessWidget{
  final String name;

  TextName(this.name);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
    );
  }
}

class IconDelete extends StatelessWidget{
  final User user;
  IconDelete(this.user);  

  @override
  Widget build(BuildContext context){    

    return GestureDetector(
      onTap: () => deleteDialog(context, user),
      child: Container(               
        alignment: Alignment.center,
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      )
    );
  }

  void deleteDialog(BuildContext context, User user){
    HomeProvider _provider = Provider.of<HomeProvider>(context);    

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure want to delete "${user.name}"?'),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              if(_provider.deleteUser(user)){                
                Navigator.of(context).pop();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Success'),
                  )
                );
              }
            },
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('No'),
          )
        ],
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () => gotoInsertUpdate(context, null),
      child: Icon(Icons.add),
    );
  }

  static void gotoInsertUpdate(BuildContext context, User user){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InsertUpdateLayout(user)
      )
    );
  }
}