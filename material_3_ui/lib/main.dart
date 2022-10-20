import 'package:flutter/material.dart';
import 'package:material_3_ui/color_schemes.g.dart';
import 'package:material_3_ui/material_3.dart';
import 'package:material_3_ui/theme.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: mcgpalette0,
          // cardColor: Colors.black,

          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: darkColorScheme.background,
        appBarTheme: AppBarTheme(),
      ),
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Material Theme Builder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Update with your UI',
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('a'),
                trailing: ElevatedButton(onPressed: () {}, child: Text('me')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
