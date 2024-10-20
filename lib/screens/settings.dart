import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white), // Săgeată albă
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.green[600]),
            title: Text('Profile Details'),
            onTap: () {
              // Navighează la pagina de schimbare a parolei
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens, color: Colors.green[600]),
            title: Text('Theme'),
            onTap: () {
              // Navighează la pagina setări de confidențialitate
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.green[600]),
            title: Text('Privacy settings'),
            onTap: () {
              // Navighează la pagina de schimbare a temei
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.green[600]),
            title: Text('Delete Account'),
            onTap: () {
              // Navighează la pagina "Despre aplicație"
            },
          ),
        ],
      ),
    );
  }
}
