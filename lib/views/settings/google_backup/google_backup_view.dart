import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignInAccount? _currentUser;

class GoogleBackupView extends StatefulWidget {
  const GoogleBackupView({Key? key}) : super(key: key);

  @override
  State<GoogleBackupView> createState() => _GoogleBackupViewState();
}

class _GoogleBackupViewState extends State<GoogleBackupView> {
  final GoogleSignInAccount? user = _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {}
    });

    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Google backup',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          Builder(builder: (context) {
            final GoogleSignInAccount? user = _currentUser;
            if (user != null) {
              return Column(
                children: [
                  _loggedInWidget(user),
                ],
              );
            } else {
              return _loginWidget();
            }
          }),
        ],
      ),
    );
  }

  Widget _loggedInWidget(GoogleSignInAccount user) {
    return Card(
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
    );
  }

  Widget _loginWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
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
            const Text('You are not currently signed in.'),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _handleSignOut() async {
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.disconnect();
    }
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  //Optional clientId
  //clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/drive',
  ],
);

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
