import 'package:favourite_places/voterlist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'candidatelist.dart';

class VoterRegistrationPage extends StatefulWidget {
  @override
  State<VoterRegistrationPage> createState() => _VoterRegistrationPageState();
}

class _VoterRegistrationPageState extends State<VoterRegistrationPage> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _wardController = TextEditingController();
  bool isloading = false;
  void _registerVoter()async {
    isloading = true;
    setState(() {});
    var uuid = Uuid();
    String uid = uuid.v1();
   await FirebaseFirestore.instance.collection('voters').add({
      'voter_id': uid,
      'name': _nameController.text,
      'age': int.parse(_ageController.text),
      'ward': _wardController.text,
    });
    isloading = false;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Voter registered successfully"),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController;

    _ageController;

    _wardController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Voter Registeration',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                  labelText: 'Age', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _wardController,
              decoration: InputDecoration(
                  labelText: 'Ward', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(250, 40),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10))),
              onPressed: _registerVoter,
              child: isloading ? CircularProgressIndicator(color: Colors.white,) : Text('Register'),
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
                    builder: (context) =>VotersListPage(),
                  ),
                );
              },
              child: Text('View All Voter'),
            ),
          ],
        ),
      ),
    );
  }
}
