import 'package:favourite_places/model/place.dart';
import 'package:favourite_places/provider/user_places.dart';
import 'package:favourite_places/widget/place_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_place.dart';

class Placescreen extends ConsumerStatefulWidget {
  const Placescreen({super.key});

  @override
  ConsumerState<Placescreen> createState() => _PlacescreenState();
}

class _PlacescreenState extends ConsumerState<Placescreen> {
  late Future<void> placesfuture;
  @override
  void initState() {
    placesfuture = ref.read(userplacesprovider.notifier).loadplaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userplace = ref.watch(userplacesprovider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Favourite Places'), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return addPlaceScreen();
                },
              ));
            },
            icon: const Icon(Icons.add))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting
                ?const Center(
                    child: CircularProgressIndicator(),
                  )
                : placelist(places: userplace));
          },
          future: placesfuture,
        ),
      ),
    );
  }
}
