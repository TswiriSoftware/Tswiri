import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tswiri_database/functions/general/clear_temp_directory.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tswiri_database/functions/general/calculate_directory_size.dart';

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
          _appSize(),
        ],
      ),
    );
  }

  Widget _website() {
    return Card(
      child: InkWell(
        onTap: () async {
          await _launchUrl(Uri.parse('https://www.tswiri.com/'));
        },
        child: ListTile(
          leading: const ImageIcon(
            AssetImage("assets/icons/launcher_icon.png"),
            color: tswiriOrange,
            size: 24,
          ),
          title: Text(
            'Website',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            'https://www.tswiri.com/',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _youtube() {
    return Card(
      child: InkWell(
        onTap: () async {
          await _launchUrl(Uri.parse('https://youtu.be/FwJ96Udr4NQ'));
        },
        child: ListTile(
          leading: const Icon(
            Icons.video_collection_rounded,
            color: Color.fromARGB(255, 255, 17, 0),
          ),
          title: Text(
            'Showcase video',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            'https://youtu.be/FwJ96Udr4NQ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget _appSize() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.storage,
            ),
            title: Text(
              'Storage',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.data_array,
            ),
            title: Text(
              'App Data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: FutureBuilder<double>(
              future: supportDirSize(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data!.toStringAsFixed(2)} GB');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.cached,
            ),
            title: Text(
              'Cache',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: FutureBuilder<double>(
              future: tempDirSize(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data!.toStringAsFixed(2)} GB');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            trailing: IconButton(
              onPressed: () async {
                await clearTemporaryDirectory();
                setState(() {});
              },
              icon: const Icon(Icons.clear),
            ),
          )
        ],
      ),
    );
  }
}

Future<double> supportDirSize() async {
  return calculateDirectorySize(await getApplicationSupportDirectory());
}

Future<double> tempDirSize() async {
  return calculateDirectorySize(await getTemporaryDirectory());
}



//Youtube showcase: https://youtu.be/FwJ96Udr4NQ
//Website : https://www.tswiri.com/