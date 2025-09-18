import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

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

// ---------------- TABS SCREEN ----------------
class TabsScreen extends StatefulWidget {
  @override
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
  }

  @override
  Widget build(BuildContext context) {
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
