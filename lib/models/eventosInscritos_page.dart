import 'package:flutter/material.dart';

class EventosInscritosPage extends StatefulWidget {
  const EventosInscritosPage({super.key});

  @override
  State<EventosInscritosPage> createState() => _EventosInscritosPageState();
}

class _EventosInscritosPageState extends State<EventosInscritosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 30, 37),
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
          child: Image.asset('assets/imagens/Logo_UESB.png'),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(5.0),
              textStyle: const TextStyle(fontSize: 15),
            ),
            child: const Text('Sair'),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(),
    );
  }
}
