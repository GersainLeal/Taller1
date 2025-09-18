import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

feature/taller_paso_parametros
// ROUTES
final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: 'detail',
      path: '/detail/:message',
     builder: (context, state) {
   final message = state.pathParameters['message'] ?? 'no-message';
  return DetailScreen(message: Uri.decodeComponent(message));
  },
),

    GoRoute(
      name: 'tabs',
      path: '/tabs',
      builder: (context, state) => TabsScreen(),
    ),
  ],
);

/// Ajusta estas constantes con tu nombre y código si quieres
const String estudianteNombre = "Gersain Leal Muñoz";
const String estudianteCodigo = "123456789";
 main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Taller - go_router y ciclo de vida',
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

// ---------------- HOME SCREEN ----------------
class HomeScreen extends StatelessWidget {
  final items = List.generate(12, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
feature/taller_paso_parametros
    return Scaffold(
      appBar: AppBar(title: const Text('Home - GridView y navegación')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selecciona un item (GridView) o navega con go / push / replace',
              style: TextStyle(fontSize: 16),
            ),
          ),
          // GRIDVIEW (requisito)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final text = items[index];
                return GestureDetector(
                  onTap: () {
                    // PASO DE PARÁMETRO: usamos push para mostrar comportamiento de "apilar"
                    final encoded = Uri.encodeComponent('$text desde Grid');
                    context.push('/detail/$encoded');
                  },
                  child: Card(
                    child: Center(child: Text(text)),
                  ),
                );
              },
            ),
          ),
          // BOTONES para mostrar go, push y replace
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final msg = Uri.encodeComponent('Mensaje con go');
                      // context.go cambia la ubicación (navegación "directa")
                      context.go('/detail/$msg');
                    },
                    child: Text('Ir con go()'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final msg = Uri.encodeComponent('Mensaje con push');
                      // context.push apila la nueva ruta en el stack (puedes volver atrás)
                      context.push('/detail/$msg');
                    },
                    child: Text('Ir con push()'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final msg = Uri.encodeComponent('Mensaje con replace');
                      // reemplaza la ruta actual (comportamiento similar a pushReplacement)
                      // usando GoRouter.of(context).replace(...)
                      GoRouter.of(context).replace('/detail/$msg');
                    },
                    child: Text('Ir con replace()'),
                  ),
                ),
              ],
            ),
          ),
          // BOTÓN a pantalla con TabBar
          Padding(
            padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
            child: ElevatedButton(
              onPressed: () => context.push('/tabs'),
              child: Text('Ir a Tabs (TabBar)'),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- DETAIL SCREEN ----------------
// Este StatefulWidget demuestra el ciclo de vida
class DetailScreen extends StatefulWidget {
  final String message;
  const DetailScreen({Key? key, required this.message}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int counter = 0;

  // initState: se llama una vez cuando se crea el State.
  @override
  void initState() {
    super.initState();
    print('DetailScreen: initState() -> inicialización del State. message=${widget.message}');
  }

  // didChangeDependencies: se llama cuando cambian dependencias (ej. InheritedWidget).
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('DetailScreen: didChangeDependencies() -> dependencias actualizadas.');
  }

  // build: se llama cada vez que se debe dibujar la UI.
  @override
  Widget build(BuildContext context) {
    print('DetailScreen: build() -> se reconstruye la UI.');
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Parametro recibido: "${widget.message}"', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Counter: $counter'),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // setState: actualizar estado y forzar rebuild.
                setState(() {
                  counter++;
                });
                print('DetailScreen: setState() -> se incrementó counter a $counter');
              },
              child: Text('Incrementar contador (setState)'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Volver (pop)
                context.pop();
              },
              child: Text('Volver (pop)'),
            ),
          ],
        ),
      ),
    );
  }

  // dispose: se llama cuando el State se elimina (ej. al hacer pop y liberar recursos).
  @override
  void dispose() {
    print('DetailScreen: dispose() -> limpieza antes de destruir State.');
    super.dispose();
  }
}

    return MaterialApp(
      title: 'Taller 1 - Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
main

// ---------------- TABS SCREEN ----------------
class TabsScreen extends StatefulWidget {
  @override
feature/taller_paso_parametros
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('TabsScreen: initState()');
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    print('TabsScreen: dispose()');
    _tabController.dispose();
    super.dispose();

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appBarTitle = "Hola, Flutter";

  void _toggleTitle() {
    setState(() {
      appBarTitle =
          appBarTitle == "Hola, Flutter" ? "¡Título cambiado!" : "Hola, Flutter";
    });

    // Muestra SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Título actualizado")),
    );
main
  }

  @override
  Widget build(BuildContext context) {
feature/taller_paso_parametros
    print('TabsScreen: build()');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs Screen'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Grid'),
            Tab(text: 'Third'),
            Tab(text: 'Info'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1) Grid: reutilizamos una versión pequeña
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(6, (i) => Card(child: Center(child: Text('G${i+1}')))),
          ),
          // 2) Third widget: ExpansionPanelList (ejemplo)
          ThirdWidget(),
          // 3) Info: muestra breve ayuda
          Center(child: Text('Pantalla Info\nAquí puedes explicar las rutas.')),
        ],
      ),

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Nombre centrado del estudiante
            Center(
              child: Text(
                "Nombre completo: $estudianteNombre",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Row con imagen remota y imagen local (asset)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Imagen desde internet (usa picsum para ejemplo estable)
                Image.network(
                  'https://picsum.photos/200/200',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(child: Icon(Icons.broken_image, size: 48)),
                    );
                  },
                ),

                // Imagen desde assets (asegúrate de tener assets/logo.png)
                Image.asset(
                  'assets/logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Botón que usa setState() para alternar título
            ElevatedButton(
              onPressed: _toggleTitle,
              child: const Text("Cambiar título"),
            ),

            const SizedBox(height: 16),

            // Un Container con márgenes, color y borde (uno de los widgets extra)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                border: Border.all(color: Colors.indigo, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Este Container tiene margenes, color y borde.",
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // Lista (ListView) como widget extra — usa Expanded para que ocupe espacio
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8),
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text("Elemento de la lista 1"),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text("Elemento de la lista 2"),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text("Elemento de la lista 3"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Un botón adicional con icono (opcional, buena práctica)
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Acción adicional ejecutada")),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text("Acción extra"),
            ),

            const SizedBox(height: 8),

            // Pie con el código del estudiante
            Text("Código: $estudianteCodigo", style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
main
    );
  }
}

// ---------------- THIRD WIDGET ----------------
class ThirdWidget extends StatefulWidget {
  @override
  _ThirdWidgetState createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  List<bool> _open = [false, false, false];

  @override
  void initState() {
    super.initState();
    print('ThirdWidget: initState()');
  }

  @override
  Widget build(BuildContext context) {
    print('ThirdWidget: build()');
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (i, isOpen) {
          setState(() => _open[i] = !isOpen);
        },
        children: List.generate(3, (i) {
          return ExpansionPanel(
            headerBuilder: (_, __) => ListTile(title: Text('Panel ${i + 1}')),
            body: ListTile(title: Text('Contenido del panel ${i + 1}')),
            isExpanded: _open[i],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    print('ThirdWidget: dispose()');
    super.dispose();
  }
}
