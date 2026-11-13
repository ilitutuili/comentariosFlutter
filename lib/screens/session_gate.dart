import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'post_page.dart';

class SessionGate extends StatefulWidget {
  const SessionGate({super.key});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  bool _carregando = true;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _carregarSessao();
  }

  Future<void> _carregarSessao() async {
    final preferencias = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _userId = preferencias.getInt('userId');
      _carregando = false;
    });
  }

  void _aoEntrar(int userId) {
    setState(() => _userId = userId);
  }

  Future<void> _sair() async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.remove('userId');
    await preferencias.remove('username');

    if (!mounted) return;

    setState(() => _userId = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_userId == null) {
      return LoginPage(onLogin: _aoEntrar);
    }

    return PostsPage(
      userId: _userId!,
      onLogout: _sair,
    );
  }
}