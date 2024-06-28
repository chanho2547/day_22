import 'package:day_22/features/profile/views/privacy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<PrivacyScreen> {
  bool _isON = false;

  void _onPrivacyProfileTap() {
    setState(() {
      _isON = !_isON;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                onTap: _onPrivacyProfileTap,
                splashColor: Colors.transparent,
                leading: const FaIcon(FontAwesomeIcons.lock),
                title: const Text(
                  "Privacy Profile",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: _isON,
                  onChanged: (x) => _onPrivacyProfileTap(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
