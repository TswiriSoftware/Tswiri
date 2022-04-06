import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

GoogleSignInAccount? _currentUser;

class GoogleLoginView extends StatefulWidget {
  const GoogleLoginView({Key? key}) : super(key: key);

  @override
  State<GoogleLoginView> createState() => _GoogleLoginViewState();
}

class _GoogleLoginViewState extends State<GoogleLoginView> {
  final GoogleSignInAccount? user = _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        //_handleGetContact(_currentUser!);
      }
    });

    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Login',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          final GoogleSignInAccount? user = _currentUser;
          if (user != null) {
            return Column(
              children: [
                OrangeOutlineContainer(
                  child: ListTile(
                    leading: GoogleUserCircleAvatar(
                      identity: user,
                    ),
                    title: Text(user.displayName ?? ''),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      onPressed: () {
                        _handleSignOut();
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ),
                ),
                const Text('You are signed in.'),
              ],
            );
          } else {
            return Column(
              children: [
                OrangeOutlineContainer(
                  child: ListTile(
                    title: Text(
                      'Please login',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _handleSignIn();
                      },
                      icon: const Icon(Icons.login),
                    ),
                  ),
                ),
                const Text('You are not currently signed in.'),
              ],
            );
          }
        }),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  //Optional clientId
  //clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/drive',
  ],
);
