import 'package:favourite_places/partylist.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';



class RegisterPartyPage extends StatefulWidget {
  @override
  State<RegisterPartyPage> createState() => _RegisterPartyPageState();
}

class _RegisterPartyPageState extends State<RegisterPartyPage> {
  final _partyNameController = TextEditingController();
  final _symbolController = TextEditingController();
  bool isLoading = false;

  void _registerParty() async {
    isLoading = true;
    setState(() {});
    var uuid = Uuid();
    String uid = uuid.v1();
    await FirebaseFirestore.instance.collection('parties').add({
      "party_id": uid,
      'partyName': _partyNameController.text,
      'symbol': _symbolController.text,
    });
    isLoading = false;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Party registered successfully"),
      ),
    );
  }

  @override
  void dispose() {
    _partyNameController.dispose();
    _symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Register Party',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _partyNameController,
              decoration: InputDecoration(
                labelText: 'Party Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _symbolController,
              decoration: InputDecoration(
                labelText: 'Symbol',
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
              onPressed: _registerParty,
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
                    builder: (context) => PartiesListPage(),
                  ),
                );
              },
              child: Text('View All Party'),
            ),
          ],
        ),
      ),
    );
  }
}
