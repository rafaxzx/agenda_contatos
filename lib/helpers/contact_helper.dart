//import 'package:sqflite/sqflite.dart';

const idColumn = "idColumn";
const nameColumn = "nameColumn";
const emailColumn = "emailColumn";
const phoneColumn = "phoneColumn";
const imgColumn = "imgColumn";

class ContacHelper {}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if (idColumn != null) map[idColumn] = id;
    return map;
  }

  @override
  String toString() {
    return "Contact(id:$id, name:$name, email:$email, phone:$phone, img:$img)";
  }
}
