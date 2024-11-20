import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Função principal que inicia o aplicativo
void main() {
  runApp(const MyApp());
}

// Widget principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provedor de estado para o aplicativo
      create: (context) => MyAppState(),
      child: MaterialApp(
        // Título do aplicativo
        title: "First App Flutter",
        // Tema do aplicativo usando Material 3
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(),
        ),
        // Página inicial do aplicativo
        home: MyHomePage(),
      ),
    );
  }
}

// Classe que gerencia o estado do aplicativo
class MyAppState extends ChangeNotifier {
  // Palavra atual gerada aleatoriamente
  var current = WordPair.random();

  // Método para gerar a próxima palavra aleatória
  void getNext() {
    current = WordPair.random();
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
  }
}

// Página inicial do aplicativo
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o estado do aplicativo
    var appState = context.watch<MyAppState>();

    return Scaffold(
      // Estrutura básica da página
      body: Column(
        children: [
          // Texto fixo
          Text('A random idea:'),
          // Texto que exibe a palavra aleatória atual
          Text(appState.current.asLowerCase),
          // Botão para gerar a próxima palavra
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () => appState.getNext(),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}