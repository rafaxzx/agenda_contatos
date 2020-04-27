import 'package:agendacontatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "Renata";
    c.email = "renata@gmail.com";
    c.phone = "41733620";
    c.img = "imgRenata";
    helper.saveContact(c);

    helper.getAllContacts().then((onValue) {
      print("QUANTIDADE DE CONTATOS INSERIDOS: $onValue");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
