import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'candidatelist.dart';

class CandidateRegistrationPage extends StatefulWidget {
  @override
  State<CandidateRegistrationPage> createState() =>
      _CandidateRegistrationPageState();
}

class _CandidateRegistrationPageState extends State<CandidateRegistrationPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _wardController = TextEditingController();
  final _partyController = TextEditingController();
  bool isLoading = false;

  void _registerCandidate() async {
    isLoading = true;
    setState(() {});
    var uuid = Uuid();
    String uid = uuid.v1();
    await FirebaseFirestore.instance.collection('candidates').add({
      'candidate_id': uid,
      'name': _nameController.text,
      'age': int.parse(_ageController.text),
      'ward': _wardController.text,
      'party': _partyController.text,
    });
    isLoading = false;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Candidate registered successfully"),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _wardController.dispose();
    _partyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Candidate Registration',
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
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _wardController,
              decoration: InputDecoration(
                labelText: 'Ward',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _partyController,
              decoration: InputDecoration(
                labelText: 'Party Name',
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
              onPressed: _registerCandidate,
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
                    builder: (context) => CandidatesListPage(),
                  ),
                );
              },
              child: Text('View All candidate'),
            ),
          ],
        ),
      ),
    );
  }
}
