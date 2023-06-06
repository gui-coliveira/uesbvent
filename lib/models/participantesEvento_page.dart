import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uesbvent/models/cadastroCertificado_page.dart';
import 'criarEvento_page.dart';
import 'evento.dart';
import 'membros_page.dart';
import 'notificacao_page.dart';
import 'usuario.dart';
import 'package:uesbvent/models/organizador_page.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

class ParticipantesEventoPage extends StatefulWidget {
  final Evento evento;
  ParticipantesEventoPage(this.evento);

  @override
  State<ParticipantesEventoPage> createState() =>
      _ParticipantesEventoPageState();
}

class _ParticipantesEventoPageState extends State<ParticipantesEventoPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_universidade.png'),
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
                      return buildUsuario(usuario);
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

  Widget buildUsuario(Usuario usuario) => ListTile(
        leading: CircleAvatar(child: Text('${usuario.nome[0]}')),
        title: Text(usuario.nome),
        subtitle: Text(usuario.email),
        trailing: TextButton(
          child: Text('Emitir certificado'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CadastroCertificadoPage()));
          },
        ),
      );
}
