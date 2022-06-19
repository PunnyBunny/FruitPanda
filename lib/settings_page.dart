import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruit_panda/settings_state.dart';
import 'package:fruit_panda/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsState _state = SettingsState(music: true, sound: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();

      final json = prefs.getString("settings");
      setState(() {
        if (json != null) {
          _state = SettingsState.fromJson(jsonDecode(json));
        }
      });
    });
  }

  @override
  void dispose() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("settings", jsonEncode(_state.toJson()));
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WithBackground(
      child: Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("Music")),
                    Checkbox(
                      value: _state.music,
                      onChanged: (val) => setState(() {
                        _state.music = val!;
                      }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: Text("Sound")),
                    Checkbox(
                      value: _state.sound,
                      onChanged: (val) => setState(() {
                        _state.sound = val!;
                      }),
                    ),
                  ],
                ),
                if (debug)
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                    },
                    child: const Text("Delete prefs"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
