import 'package:day_22/features/profile/views/privacy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _onPrivacyTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrivacyScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
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
              const ListTile(
                leading: FaIcon(FontAwesomeIcons.userPlus),
                title: Text(
                  "Follow and invite friends",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const ListTile(
                leading: FaIcon(FontAwesomeIcons.bell),
                title: Text(
                  "Notification",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                onTap: _onPrivacyTap,
                splashColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                leading: const FaIcon(FontAwesomeIcons.lock),
                title: const Text(
                  "Privacy",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const ListTile(
                leading: FaIcon(FontAwesomeIcons.user),
                title: Text(
                  "account",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
