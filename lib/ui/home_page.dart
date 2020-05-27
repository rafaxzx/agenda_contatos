import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:agendacontatos/helpers/contact_helper.dart';
import 'package:agendacontatos/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
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
          onPressed: () => _showContactPage()),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) => _contactCard(context, index)),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: contacts[index].img != null
                    ? FileImage(File(contacts[index].img))
                    : AssetImage("images/person.png"),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacts[index].email ?? "",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        contacts[index].phone ?? "",
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () => _showOptions(context, index),
//      onTap: () => _showContactPage(contact: listContacts[index]),
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    //Diminui ao maximo o espaço ocupado pelo BottomSheet
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Ligar",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                          onPressed: () {
                            launch("tel:${contacts[index].phone}");
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Text("Editar",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 20.0)),
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: contacts[index]);
                          },
                        ),
                      ),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FlatButton(
                            child: Text("Excluir",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20.0)),
                            onPressed: () {
                              helper.deleteContact(contacts[index].id);
                              setState(() {
                                contacts.removeAt(index);
                                Navigator.pop(context);
                              });
                            },
                          )),
                    ],
                  ));
            },
          );
        });
  }
}
