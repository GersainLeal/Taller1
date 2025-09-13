import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Ajusta estas constantes con tu nombre y código si quieres
const String estudianteNombre = "Gersain Leal Muñoz";
const String estudianteCodigo = "123456789";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

  @override
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
  }

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
