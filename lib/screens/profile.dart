import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Pentru a gestiona fișierele

import 'settings.dart'; // Importă pagina de setări

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Salvează imaginea selectată
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        iconTheme: IconThemeData(color: Colors.white), // Săgeată albă
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage, // Permite utilizatorului să apese pe avatar pentru a selecta o imagine
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) // Afișează imaginea selectată
                    : NetworkImage('https://example.com/profile-pic.jpg') // Placeholder pentru imagine
                as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                    size: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.green[600]),
              title: Text('Notification Preferences'),
              onTap: () {
                // Navighează la pagina preferințe notificări
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.green[600]),
              title: Text('Language'),
              onTap: () {
                // Navighează la pagina setări limbă
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.green[600]),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(), // Navighează la SettingsScreen
                  ),
                );
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Logică pentru logout
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
