import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoView extends StatefulWidget {
  const AppInfoView({Key? key}) : super(key: key);

  @override
  State<AppInfoView> createState() => _AppInfoViewState();
}

class _AppInfoViewState extends State<AppInfoView> {
  @override
  void initState() {
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
        'App Info',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          _website(),
          _youtube(),
        ],
      ),
    );
  }

  Widget _website() {
    return Card(
      child: ListTile(
        leading: const ImageIcon(
          AssetImage("assets/icons/launcher_icon.png"),
          color: tswiriOrange,
          size: 24,
        ),
        title: Row(
          children: [
            TextButton(
              onPressed: () async {
                await _launchUrl(Uri.parse('https://www.tswiri.com/'));
              },
              child: const Text('Website'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _youtube() {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.video_collection_rounded,
          color: Color.fromARGB(255, 255, 17, 0),
        ),
        title: Row(
          children: [
            TextButton(
              onPressed: () async {
                await _launchUrl(Uri.parse('https://youtu.be/FwJ96Udr4NQ'));
              },
              child: const Text('Showcase video'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}


//Youtube showcase: https://youtu.be/FwJ96Udr4NQ
//Website : https://www.tswiri.com/