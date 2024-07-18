import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WardListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Wards List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('wards').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['wardName']),
                subtitle: Text('Location: ${doc['location']} - offficer: ${doc['officer']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WardDetailsPage(doc),
                    ),
                  );

                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class WardDetailsPage extends StatelessWidget {
  final DocumentSnapshot doc;

  WardDetailsPage(this.doc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doc['wardName']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${doc['wardName']}',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 8),
            Text(
              'Location: ${doc['location']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Officer: ${doc['officer']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'id: ${doc['ward_id']}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
