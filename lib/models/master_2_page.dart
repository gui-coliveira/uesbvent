import 'package:flutter/material.dart';

import 'criarEvento_page.dart';
import 'organizador_page.dart';

// ignore: camel_case_types
class Master_2_Page extends StatefulWidget {
  const Master_2_Page({super.key});

  @override
  State<Master_2_Page> createState() => _Master_2_PageState();
}

// ignore: camel_case_types, unused_element
class _Master_2_PageState extends State<Master_2_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 173, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 50, 133),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          iconSize: 40,
          onPressed: () {},
        ),
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_uesb.png'),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(5.0),
              textStyle: const TextStyle(fontSize: 15),
            ),
            child: const Text('Início'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrganizadorPage()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CriarEvento_Page()));
        },
        backgroundColor: const Color.fromARGB(255, 57, 50, 133),
        child: const Icon(Icons.add),
      ),
      body: ListView(),
    );
  }
}
