import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tswiri_network_interface/client/client.dart';

class ServerSettingsView extends StatefulWidget {
  const ServerSettingsView({Key? key}) : super(key: key);

  @override
  State<ServerSettingsView> createState() => ServerSettingsViewState();
}

class ServerSettingsViewState extends State<ServerSettingsView> {
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
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _connectionState(),
          const Divider(),
          _serverIP(),
          const Divider(),
          _serverPort(),
          const Divider(),
          // OutlinedButton(
          //   onPressed: () {
          //     log(isar!.containerTypes.getSync(0)!.iconData.data.toString());
          //   },
          //   child: Text('data'),
          // ),
        ],
      ),
    );
  }

  Padding _serverIP() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: Provider.of<Client>(context).serverIP,
        onFieldSubmitted: (value) async {
          if (value.isEmpty) return;
          await Provider.of<Client>(context, listen: false).updateIP(value);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 15,
          ),
          prefix: Text('IP: '),
          hintText: 'IP',
        ),
      ),
    );
  }

  Padding _serverPort() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: Provider.of<Client>(context).serverPort.toString(),
        onFieldSubmitted: (value) async {
          if (value.isEmpty) return;
          await Provider.of<Client>(context, listen: false)
              .updatePort(int.tryParse(value) ?? 0);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 15,
          ),
          prefix: Text('Port: '),
          hintText: 'Port',
        ),
      ),
    );
  }

  ListTile _connectionState() {
    return ListTile(
      title: Provider.of<Client>(context).isConnected()
          ? const Text('Connected')
          : const Text('Disconnected'),
      subtitle: Text(Provider.of<Client>(context).serverIP ?? '-'),
      trailing: IconButton(
        onPressed: () {
          if (Provider.of<Client>(context, listen: false).ws == null) {
            Provider.of<Client>(context, listen: false).connectToServer();
          } else {
            Provider.of<Client>(context, listen: false).disconnectFromServer();
          }
        },
        icon: Provider.of<Client>(context).isConnected()
            ? const Icon(Icons.close)
            : const Icon(Icons.start),
      ),
    );
  }
}
