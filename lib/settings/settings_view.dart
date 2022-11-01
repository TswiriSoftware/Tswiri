import 'package:flutter/material.dart';
import 'package:tswiri/settings/advanced_settings/advanced_settings_view.dart';
import 'package:tswiri/settings/app_info/app_info_view.dart';
import 'package:tswiri/settings/general_settings/general_settings_view.dart';
import 'package:tswiri_theme/transitions/left_to_right_transition.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        _sliverList(),
      ],
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Settings',
        ),
        centerTitle: true,
        elevation: 5,
      ),
    );
  }

  SliverList _sliverList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        _generalSettings(),
        const Divider(),
        _advancedSettings(),
        const Divider(),
        _appInfo(),
        const Divider(),
      ]),
    );
  }

  Widget _generalSettings() {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const GeneralSettingsView()),
        );
      },
      title: const Text(
        'General Settings',
      ),
      leading: const Icon(
        Icons.settings_rounded,
      ),
    );
  }

  Widget _advancedSettings() {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const AdvancedSettingsView()),
        );
      },
      title: const Text(
        'Advanced Settings',
      ),
      leading: const Icon(
        Icons.warning_rounded,
      ),
    );
  }

  Widget _appInfo() {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const AppInfoView()),
        );
      },
      title: const Text(
        'Info',
      ),
      leading: const Icon(
        Icons.info_rounded,
      ),
    );
  }
}
