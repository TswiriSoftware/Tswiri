import 'package:flutter/material.dart';
import 'package:tswiri_theme/colors/tswiri_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoView extends StatefulWidget {
  const AppInfoView({super.key});

  @override
  State<AppInfoView> createState() => _AppInfoViewState();
}

class _AppInfoViewState extends State<AppInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 10,
      title: const Text(
        'Info',
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _website(),
          const Divider(),
          _youtubeChannel(),
          const Divider(),
          _writenTutorial(),
          const Divider(),
          // _videoTutorial(),
          // const Divider(),
        ],
      ),
    );
  }

  Widget _website() {
    return InkWell(
      onTap: () async {
        await _launchUrl(Uri.parse('https://www.tswiri.com/'));
      },
      child: const ListTile(
        leading: ImageIcon(
          AssetImage("assets/icons/tswiri_icon_192.png"),
          size: 30,
          color: tswiriOrange,
        ),
        title: Text(
          'Website',
        ),
        trailing: Icon(Icons.open_in_browser),
      ),
    );
  }

  Widget _youtubeChannel() {
    return InkWell(
      onTap: () async {
        await _launchUrl(Uri.parse(
            'https://www.youtube.com/channel/UCPJOzl96VNl1WAEyLbm5fgw'));
      },
      child: const ListTile(
        leading: Icon(
          Icons.video_collection_rounded,
          color: Color.fromARGB(255, 255, 0, 0),
          size: 25,
        ),
        title: Text(
          'Youtube',
        ),
        trailing: Icon(Icons.open_in_browser),
      ),
    );
  }

  //TODO: add this.
  // ignore: unused_element
  Widget _videoTutorial() {
    return InkWell(
      onTap: () async {
        // await _launchUrl(Uri.parse('https://youtu.be/FwJ96Udr4NQ'));
      },
      child: const ListTile(
        leading: Icon(
          Icons.video_collection_rounded,
          size: 25,
        ),
        title: Text(
          'Video Tutorial',
        ),
        subtitle: Text('Coming soon'),
        trailing: Icon(Icons.open_in_browser),
      ),
    );
  }

  Widget _writenTutorial() {
    return InkWell(
      onTap: () async {
        await _launchUrl(Uri.parse('https://www.tswiri.com/tutorial'));
      },
      child: const ListTile(
        leading: Icon(
          Icons.help_rounded,
          size: 25,
        ),
        title: Text(
          'Writen Tutrial',
        ),
        trailing: Icon(Icons.open_in_browser),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
