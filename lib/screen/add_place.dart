import 'dart:io';

import 'package:favourite_places/model/place.dart';
import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widget/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class addPlaceScreen extends ConsumerStatefulWidget {
  const addPlaceScreen({super.key});

  @override
  ConsumerState<addPlaceScreen> createState() => _adddataState();
}

class _adddataState extends ConsumerState<addPlaceScreen> {
  var titlecontroller = TextEditingController();
  File? selectedImage;
  void saveplace(){
    final enteredtext=titlecontroller.text;
    if(enteredtext.isEmpty||selectedImage==null){
      return;
    }

ref.read(userplacesprovider.notifier).addPlace(enteredtext,selectedImage!);
    Navigator.of(context).pop();
  }
  @override
  void dispose() {
    titlecontroller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Places'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: TextField(style: const TextStyle(color: Colors.white,fontSize: 15),
                  controller: titlecontroller,
                  maxLength: 50,
                  decoration:const InputDecoration(
                    constraints: BoxConstraints(maxWidth: 400),
                    labelText: 'Title',
                  ),
                ),
              ),
             const SizedBox(
                height: 20,
              ),

              ImageInput(onPicked: (image){
                setState(() {
                  selectedImage=image;
                });
              }),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton.icon(
                  onPressed: () {
                    saveplace();
                  }, icon: Icon(Icons.add), label: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}
