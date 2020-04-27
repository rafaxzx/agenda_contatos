import 'package:agendacontatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> listContacts = List();

  @override
  void initState() {
    super.initState();
    helper.getAllContacts().then((list) {
      setState(() {
        listContacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {}),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: listContacts.length,
          itemBuilder: null),
    );
  }
}
