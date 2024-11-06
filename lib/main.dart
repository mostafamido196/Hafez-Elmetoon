import 'package:flutter/material.dart';

import 'Widgets/sliver_app_bar.dart';
import 'Widgets/sliver_list.dart';
import 'Widgets/sliver_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomScrollView(
          slivers: [
            const SliverAppBarBldr(),
            const SliverSearch(),
            SliverListBldr(),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            title: Text('حافظ المتون'),
            backgroundColor:Colors.yellow.withOpacity(0.6), // Adjust opacity as needed
            elevation: 20, // Make the AppBar flat
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ],),

    );
  }
}
