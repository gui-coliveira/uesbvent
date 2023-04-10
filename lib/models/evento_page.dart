// ignore_for_file: sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:uesbvent/models/login_page.dart';

class EventoPage extends StatelessWidget {
  const EventoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_universidade.png'),
        ),

        actions: <Widget>[
          TextButton(
            child: Text('Login'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],

        // const [Icon(Icons.filter_alt_rounded)]
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 251, 201, 218),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Column(
          children: [
            const Text(
              'Título do Evento..........',
              maxLines: 3,
              textAlign: TextAlign.justify,
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Container(
                height: 286,
                width: 330,
                margin: const EdgeInsets.fromLTRB(0, 175, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Descrição............',
                      maxLines: 20,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              child: Text(
                'Inscrever-se',
                style: TextStyle(fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                minimumSize: Size(120.0, 50.0),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
