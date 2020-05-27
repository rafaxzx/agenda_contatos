import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agendacontatos/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;

  bool _userEdited = false;
  final _nameFocus = FocusNode();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedContact.name ?? "Novo Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.save),
          onPressed: () {
            if (_editedContact.name.isNotEmpty && _editedContact.name != null) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  backgroundImage: _editedContact.img != null
                      ? FileImage(File(_editedContact.img))
                      : AssetImage("images/person.png"),
                ),
              ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                },
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Phone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    print("USUARIO EDITOU: $_userEdited");
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Sair"),
                  onPressed: () {
                    print('CLICOU EM SAIR');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Voltar"),
                  onPressed: () {
                    print('CLICOU EM VOLTAR');
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      //Não permite que o botão voltar do Scaffold saia automaticamente
      return Future.value(false);
    } else {
      //Permite que o botão voltar do Scaffold saia automaticamente no caso
      //de não ter editado nada
      return Future.value(true);
    }
  }
}
