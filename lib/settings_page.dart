import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool>? _states;
  @override
  void initState() {
    super.initState();
    getStates().then((_) {
      setState(() {});
    });
  }

  Future<bool> getStates() async {
    final prefs = await SharedPreferences.getInstance();
    var states = [prefs.getBool('music'), prefs.getBool('sound')];
    if (states[0] == null) {
      prefs.setBool('music', false);
      states[0] = false;
    }
    if (states[1] == null) {
      prefs.setBool('sound', false);
      states[1] = false;
    }
    _states = states.cast<bool>();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_states == null) {
      return Container();
    }
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Padding(
          padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(child:Text("Music"),),
                      IconButton(
                        onPressed: () {
                          (() async {
                            final prefs = await SharedPreferences.getInstance();
                            _states![0] = !_states![0];
                            prefs.setBool('music', _states![0]);
                            return true;
                          })()
                              .then((_) {
                            setState(() {});
                          });
                        },
                        icon: _states![0]
                            ? const Icon(Icons.radio_button_off)
                            : const Icon(Icons.radio_button_checked),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child:Text("Sound"),),
                      IconButton(
                        onPressed: () {
                          (() async {
                            final prefs = await SharedPreferences.getInstance();
                            _states![1] = !_states![1];
                            prefs.setBool('sound', _states![1]);
                            return true;
                          })()
                              .then((_) {
                            setState(() {});
                          });
                        },
                        icon: _states![1]
                            ? const Icon(Icons.radio_button_off)
                            : const Icon(Icons.radio_button_checked),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                      }, child: const Text("Delete prefs")
                  ),
                ],
            )
            )
        ),
    );
  }
}

void pushSettingsPage(BuildContext context) async {
  // final prefs = await SharedPreferences.getInstance();
  // var musicState = prefs.getBool('music');
  // var soundState = prefs.getBool('sound');
  // if(musicState == null) {
  //   prefs.setBool('music', false);
  //   musicState = false;
  // }
  // if(soundState == null) {
  //   prefs.setBool('sound', false);
  //   soundState = false;
  // }
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const SettingsPage(),
  ));
}
