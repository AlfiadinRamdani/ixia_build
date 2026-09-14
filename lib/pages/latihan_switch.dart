import 'package:flutter/material.dart';

class LatihanSwitch extends StatefulWidget {
  const LatihanSwitch({super.key});

  @override
  State<LatihanSwitch> createState() => _LatihanSwitchState();
}

class _LatihanSwitchState extends State<LatihanSwitch> {
  bool _switchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _switchState ? Colors.black : const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text('latihan switch '),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: _switchState,
              onChanged: (value) {
                setState(() {
                  _switchState = !_switchState;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
