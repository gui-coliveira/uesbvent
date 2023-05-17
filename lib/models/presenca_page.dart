import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/usuario.dart';

import 'evento.dart';

class PresencaPage extends StatefulWidget {
  final Evento evento;
  PresencaPage(this.evento);

  @override
  State<PresencaPage> createState() => _PresencaPageState();
}

class _PresencaPageState extends State<PresencaPage> {
  List<Map<String, dynamic>> inscricoes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeInscricoes();
  }

  void initializeInscricoes() async {
    final inscricoesSnapshot = await FirebaseFirestore.instance
        .collection('inscricoes')
        .where('eventoId', isEqualTo: widget.evento.id)
        .get();

    setState(() {
      inscricoes = inscricoesSnapshot.docs.map((doc) => doc.data()).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 254),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('Validar Presença '),
                      Icon(Icons.domain_verification),
                    ],
                  ),
                  Text(widget.evento.title),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: inscricoes.length,
              itemBuilder: (context, index) {
                final inscricao = inscricoes[index];
                final usuarioId = inscricao['usuarioId'].toString();
                final presente = inscricao['presente'].toString();

                return FutureBuilder<Usuario>(
                  future: readUsuario(usuarioId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // Exibe um espaço em branco enquanto aguarda o carregamento do usuário
                    }
                    if (snapshot.hasData) {
                      final usuario = snapshot.data!;
                      return buildUsuario(usuario, presente == 's');
                    } else {
                      return Container(); // Exibe um espaço em branco caso não seja possível carregar o usuário
                    }
                  },
                );
              },
            ),
    );
  }

  Future<Usuario> readUsuario(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .get();
    final data = snapshot.data();
    if (data != null) {
      return Usuario.fromJson(data);
    } else {
      throw Exception('Failed to load usuario');
    }
  }

  Widget buildUsuario(Usuario usuario, bool isConfirmed) {
    return ListTile(
      leading: CircleAvatar(child: Text('${usuario.nome[0]}')),
      title: Text(usuario.nome),
      subtitle: Text(usuario.email),
      trailing: ElevatedButton(
        onPressed: () {
          setState(() {
            toggleConfirmation(usuario.id);
          });
          updateConfirmationStatus(usuario.id, !isConfirmed);
        },
        child: isConfirmed ? Icon(Icons.check) : SizedBox(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: CircleBorder(),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  void toggleConfirmation(String userId) {
    setState(() {
      final index = inscricoes
          .indexWhere((inscricao) => inscricao['usuarioId'] == userId);
      if (index != -1) {
        final presente = inscricoes[index]['presente'].toString();
        inscricoes[index]['presente'] = presente == 's' ? 'n' : 's';
      }
    });
  }

  void updateConfirmationStatus(String userId, bool isConfirmed) async {
    final inscricoesSnapshot = await FirebaseFirestore.instance
        .collection('inscricoes')
        .where('eventoId', isEqualTo: widget.evento.id)
        .where('usuarioId', isEqualTo: userId)
        .get();

    final docId = inscricoesSnapshot.docs.first.id;
    await FirebaseFirestore.instance
        .collection('inscricoes')
        .doc(docId)
        .update({'presente': isConfirmed ? 's' : 'n'});
  }
}
