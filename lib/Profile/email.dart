import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_fonts/google_fonts.dart';

class UserEmail extends StatefulWidget {
  static const String id = "email";

  @override
  _UserEmailState createState() => _UserEmailState();
}

class _UserEmailState extends State<UserEmail> {
  final _activeUser = FirebaseAuth.instance.currentUser;
  String _setEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,

      body: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Set Your Profile Name',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 20.0),

                TextField(
                  onChanged: (value) {
                    _setEmail = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                  ),
                ),

                SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                    ),

                    RaisedButton(
                      onPressed: () async {
                        try {
                          await _activeUser.updateProfile(
                              displayName: _setEmail
                          );
                          if (_setEmail != null) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}