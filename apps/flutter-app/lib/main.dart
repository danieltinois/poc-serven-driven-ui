import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poc_design_tokens/tokens.dart';

import 'models/dynamic_screen.dart';
import 'renderer/dynamic_screen_renderer.dart';

void main() {
  runApp(const ServerDrivenUiApp());
}

class ServerDrivenUiApp extends StatelessWidget {
  const ServerDrivenUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDUI POC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PocColors.primary),
        scaffoldBackgroundColor: PocColors.background,
        fontFamily: PocTypography.fontFamily,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DynamicScreen> _screenFuture;

  // Android emulator acessa o localhost da maquina host via 10.0.2.2.
  // Para iOS simulator, troque para http://localhost:3333/screen/home.
  static const screenUrl = 'http://10.0.2.2:3333/screen/home';

  @override
  void initState() {
    super.initState();
    _screenFuture = _fetchScreen();
  }

  Future<DynamicScreen> _fetchScreen() async {
    final response = await http.get(Uri.parse(screenUrl));

    if (response.statusCode != 200) {
      throw Exception('API retornou HTTP ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return DynamicScreen.fromJson(json);
  }

  void _reload() {
    setState(() {
      _screenFuture = _fetchScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter SDUI')),
      body: FutureBuilder<DynamicScreen>(
        future: _screenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(PocSpacing.lg),
                child: Text(
                  'Erro ao carregar tela: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final screen = snapshot.requireData;

          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView(
              padding: const EdgeInsets.all(PocSpacing.lg),
              children: [
                Text(
                  'screen: ${screen.screen} | version: ${screen.version}',
                  style: const TextStyle(
                    color: PocColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: PocSpacing.md),
                DynamicScreenRenderer(blocks: screen.blocks),
              ],
            ),
          );
        },
      ),
    );
  }
}
