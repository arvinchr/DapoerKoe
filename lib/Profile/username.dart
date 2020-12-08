import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';

class UserDisplayName extends StatefulWidget {
  static const String id = 'userdisplayname';

  @override
  _UserDisplayNameState createState() => _UserDisplayNameState();
}

class _UserDisplayNameState extends State<UserDisplayName> {

  final _activeUser = FirebaseAuth.instance.currentUser;
  String _setDisplayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.amber,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Set Your Profile Name',
                  style: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),

                SizedBox(height: 20.0),

                TextField(
                  onChanged: (value) {
                    _setDisplayName = value;
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
                              displayName: _setDisplayName
                          );
                          if (_setDisplayName != null) {
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
