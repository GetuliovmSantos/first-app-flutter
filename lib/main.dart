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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(0, 255, 0, 1.0),
          ),
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

  // Lista de palavras favoritas
  List<WordPair> favorites = [];

  // Método para adicionar ou remover a palavra atual dos favoritos
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
    print(favorites); // Imprime a lista de favoritos no console
  }
}

// Página inicial do aplicativo
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o estado do aplicativo
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);

    // Define o ícone com base no estado de favorito
    IconData icon;
    appState.favorites.contains(pair)
        ? icon = Icons.favorite
        : icon = Icons.favorite_border;

    return Scaffold(
      // Estrutura básica da página
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe a palavra aleatória atual em um cartão grande
            BigCard(pair: pair),
            SizedBox(
              height: 10,
            ),
            // Botões para interagir com a palavra atual
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botão para adicionar ou remover a palavra dos favoritos
                ElevatedButton.icon(
                  onPressed: () => appState.toggleFavorite(),
                  label: Text(
                    "Like",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  icon: Icon(
                    icon,
                    color: theme.colorScheme.onPrimary,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(theme.colorScheme.secondary),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(theme.colorScheme.secondary),
                  ),
                  onPressed: () => appState.getNext(),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget que exibe a palavra aleatória em um cartão grande
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  // Par de palavras geradas aleatoriamente
  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // Obtém o tema atual do contexto
    final theme = Theme.of(context);

    // Obtém o estilo de texto displayMedium e modifica a cor para onPrimary
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      // Define a cor de fundo do Card como a cor primária do tema
      color: theme.colorScheme.primary,
      child: Padding(
        // Define o padding interno do Card
        padding: const EdgeInsets.all(20),
        child: Text(
          // Exibe a palavra em formato PascalCase
          pair.asPascalCase,
          // Aplica o estilo de texto modificado
          style: style,
          // Define um rótulo semântico para acessibilidade
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
