import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../model/auth.dart';

class UserModel extends Model {
  Future<Map<String,dynamic>> authentication(String email, String password,AuthType authtype) async {
    http.Response response;
    Map<String,dynamic> responseData;
    Map<String, dynamic> detail = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    if(authtype == AuthType.SignUp){
      response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBMftWPxvFPN0nYBIxvDEtVI3eLrulF2wE',
          body: json.encode(detail),
          headers: {
            'content-Type':'application/json'
          });
    }
    if(authtype == AuthType.Login){
     response = await http.post(
         'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBMftWPxvFPN0nYBIxvDEtVI3eLrulF2wE',
          body: jsonEncode(detail),
          headers: {
           'content-Type':'application/json'
         });
    }
    responseData = json.decode(response.body);
    bool success = false;
    String message = 'Error!! Try Again';
    String titleMessage = '';
    print(response.body.toString());
    if(responseData.containsKey('kind')){
      success = true;
      if(responseData['kind'] == 'identitytoolkit#SignupNewUserResponse'){
        titleMessage = 'Congratulations';
        message = 'Successfully Done\n Now you are the member of ZO.\n';
      }else{
        titleMessage = 'login';
      }
    }
    else if(responseData['error']['message'] == 'EMAIL_EXISTS'){
      success = false;
      titleMessage = 'Error!!';
      message = 'ID Already Exist';
    }
    else if(responseData['error']['message'] == 'EMAIL_NOT_FOUND'){
      titleMessage = 'Email not Found';
      success = false;
      message = 'You don\'t have Account\n To be member Create your Account';
    }else if(responseData['error']['message'] == 'INVALID_PASSWORD'){
      titleMessage = 'Error!!';
      success = false;
      message = 'Invalid password!! please try with different password.';
    }

    return {'success': success,
             'titleMessage': titleMessage,
            'message': message};
  }
}
