import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDemo extends StatefulWidget {
  const FirebaseDemo({super.key});

  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Controllers for input fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Write Data
  void _writeData(String id, String name, int age) async {
    await _database.child("Users").child(id).set({
      "Name": name,
      "Age": age,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data written!")));
  }

  // Read Data
  void _readData(String id) async {
    final snapshot = await _database.child("Users").child(id).get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Name: ${data['Name']}, Age: ${data['Age']}")),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No data found!")));
    }
  }

  // Update Data
  void _updateData(String id, String name, int age) async {
    await _database.child("Users").child(id).update({
      "Name": name,
      "Age": age,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data updated!")));
  }

  // Delete Data
  void _deleteData(String id) async {
    await _database.child("Users").child(id).remove();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data deleted!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Realtime Database Demo",style:  TextStyle(color: Colors.white),),
      backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(
                    labelText: "User ID", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                    labelText: "Age", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: const Size(150, 50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      _writeData(
                        _idController.text,
                        _nameController.text,
                        int.tryParse(_ageController.text) ?? 0,
                      );
                    },
                    child: const Text("Write",style:  TextStyle(fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: Size(150, 50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () => _readData(_idController.text),
                    child: Text("Read",style:  TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: Size(150, 50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      _updateData(
                        _idController.text,
                        _nameController.text,
                        int.tryParse(_ageController.text) ?? 0,
                      );
                    },
                    child: Text("Update",style:  TextStyle(fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        fixedSize: Size(150, 50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () => _deleteData(_idController.text),
                    child: Text("Delete",style:  TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
