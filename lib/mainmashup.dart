import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        _googleSignIn.currentUser.photoUrl,
                        height: 120.0,
                        width: 120.0,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(_googleSignIn.currentUser.displayName),
                      SizedBox(
                        height: 10,
                      ),
                      Text(_googleSignIn.currentUser.email),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ],
                          ),
                        ),
                        child: FlatButton(
                          child: Text("Logout"),
                          onPressed: () {
                            _logout();
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/undraw_secure_login_pdn4.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Center(
                      child: FlatButton(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(66.0, 0.0, 0, 2.0),
                          child: Text(
                            "Login with Google",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico"),
                          ),
                        ),
                        onPressed: () {
                          _login();
                        },
                      ),
                    ),
                  )),
      ),
    );
  }
}
