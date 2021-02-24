import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zo_demo/pages/homepage.dart';

import '../model/auth.dart';
import '../scoped_model/main.dart';

class Auth extends StatefulWidget {
 @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}
class _AuthState extends State<Auth>{
  AuthType _authType = AuthType.Login;
  final TextEditingController _PasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String emailInitial = '';
    String passwordInitial = '';
    return Scaffold(
        appBar: AppBar(
          title: Center(child:Text(_authType == AuthType.Login ?'Login':'Create Account',)),
        ),
        body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(

                key: _formKey,
                child:Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: emailInitial,
                    onSaved: (String value){
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,
                          color: Theme.of(context).accentColor),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onSaved: (String value){
                      password = value;
                      _PasswordController.clear();
                    },
                    controller: _PasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key,
                          color: Theme.of(context).accentColor),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _authType == AuthType.Login ? Container() : TextFormField(
                    initialValue: '',
                    validator: (String value){
                      if(_PasswordController.text != value)
                        return 'Password not match';
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key,
                          color: Theme.of(context).accentColor),
                      labelText: 'Confirm Password',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        if(_authType == AuthType.Login)
                          _authType = AuthType.SignUp;
                        else
                          _authType = AuthType.Login;
                      });
                    },
                    child: Text(
                      _authType ==AuthType.Login ?'Create an Account':'Have an Account',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'RobotoSlab'),
                    ),
                  ),
                  ScopedModelDescendant<MainModel>(builder: (BuildContext context,Widget child,MainModel model){
                   return RaisedButton(
                      onPressed: () async {
                        Map<String,dynamic> _returnData;
                        _formKey.currentState.validate();
                        _formKey.currentState.save();
                      _returnData = await model.authentication(email, password,_authType);
                       if(_returnData != null && _returnData['titleMessage'] != 'login'){
                          showDialog(context: context,builder:(BuildContext context) {
                            return AlertDialog(title: Text(_returnData['titleMessage']),content: Text(_returnData['message']),actions: <Widget>[
                               RaisedButton(child: Text(_returnData['success']?'Continue':'Try Again',style: TextStyle(color: Theme.of(context).primaryColor)),onPressed: (){
                                  if(_returnData['success']){
                                   print('successed');
                                     Navigator.of(context).pop();

                                   }else{
                                     Navigator.of(context).pop();
                                   }
                              },
                               color: Theme.of(context).accentColor
                                 ,),
                              _returnData['titleMessage']=='Email not Found'?RaisedButton(child: Text('Create Account',style: TextStyle(color: Theme.of(context).primaryColor),),onPressed: (){
                                Navigator.of(context).pop();
                                setState(() {
                                  _authType = AuthType.SignUp;
                                });
                              },color: Theme.of(context).accentColor,):Container(),
                            ],);
                          });
                       }else{
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Homepage()), (route) => false);
                       }
                      },
                      child: Text(
                        'continue',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontFamily: 'RobotoSlab'),
                      ),
                      color: Theme.of(context).accentColor,
                    );
                  },),
                ],
              ),)
            )));
  }
}
