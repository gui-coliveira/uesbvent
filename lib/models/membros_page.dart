import 'package:flutter/material.dart';
import 'package:uesbvent/models/home_page.dart';
import 'edit_membros.dart';

class MembrosPage extends StatefulWidget {
  const MembrosPage({super.key});

  @override
  State<MembrosPage> createState() => _OrganizadoresPageState();
}

class _OrganizadoresPageState extends State<MembrosPage> {
  int _indiceAtual = 0; // Variável para controlar o índice das telas
  final List<Widget> _telas = [
    const EditMembros("Membros"),
    const EditMembros("Organizadores")
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 207, 207),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_universidade.png'),
        ),
      ),
      body: _telas[_indiceAtual], //Alterando posição da lista
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrangeAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _indiceAtual,
        onTap: onTabTapped, //Chamando método ao clicar em uma das opções
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Membros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Organizadores',
          ),
        ],
      ),
    );
  }
}
