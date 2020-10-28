import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FBLogin extends StatefulWidget {
  @override
  _FBLoginState createState() => _FBLoginState();
}

class _FBLoginState extends State<FBLogin> {
  static final FacebookLogin facebookSignIn = FacebookLogin();

  String _message = ' ';

  Future<Null> _login() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         User Logged in with 
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         ''');

        /* You can now save the user in DB with the token. */

        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong! \n'
            '${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Facebook login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_message),
              RaisedButton(
                onPressed: _login,
                child: Text('Log in'),
              ),
              RaisedButton(
                onPressed: _logOut,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
