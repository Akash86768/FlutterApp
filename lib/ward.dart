import 'package:favourite_places/wardlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'candidatelist.dart';

class RegisterWardPage extends StatefulWidget {
  @override
  State<RegisterWardPage> createState() => _RegisterWardPageState();
}

class _RegisterWardPageState extends State<RegisterWardPage> {
  final _wardNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _officerController = TextEditingController();
  bool isLoading = false;

  void _registerWard() async {
    isLoading = true;
    setState(() {});
    var uuid = Uuid();
    String uid = uuid.v1();
    await FirebaseFirestore.instance.collection('wards').add({
      'ward_id': uid,
      'wardName': _wardNameController.text,
      'location': _locationController.text,
      'officer': _officerController.text,
    });
    isLoading = false;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Ward registered successfully"),
      ),
    );
  }

  @override
  void dispose() {
    _wardNameController.dispose();
    _locationController.dispose();
    _officerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Register Ward',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _wardNameController,
              decoration: InputDecoration(
                labelText: 'Ward Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _officerController,
              decoration: InputDecoration(
                labelText: 'Officer Alloted',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 40),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _registerWard,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Register'),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 40),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WardListPage(),
                  ),
                );
              },
              child: Text('View All Wards'),
            ),
          ],
        ),
      ),
    );
  }
}
