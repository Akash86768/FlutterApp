import 'dart:io';
import 'package:uuid/uuid.dart';

final uuid=Uuid();

class Place {
  //we can give our own id but if we don't want to give then it will generate it's own id by uuid.v4()
  Place({required this.title,required this.image,String? id}) : id=id??uuid.v4();
  final String title;
  final String id;
  final File image;
}
