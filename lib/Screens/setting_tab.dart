import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your settings screen UI here, including the navigation bar with toggle/switch button
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['True', 'False'],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ],
        ),
      ),
    );
  }
}