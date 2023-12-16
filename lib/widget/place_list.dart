import 'package:flutter/material.dart';

import '../model/place.dart';
import '../screen/placesdetail.dart';

class placelist extends StatelessWidget {
  final List<Place> places;

  placelist({super.key, required this.places});
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
          child: Text(
        "No places added..Try adding some",
        style: Theme.of(context).textTheme.titleLarge,
      ));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
              radius: 30, backgroundImage: FileImage(places[index].image)),
          title: Text(places[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 25)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PlaceDetailScreen(place: places[index]);
              },
            ));
          },
        );
      },
      itemCount: places.length,
    );
  }
}
