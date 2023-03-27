import 'package:flutter/material.dart';
import 'package:news_app/providers/news.dart';
import 'package:news_app/screens/front_page.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/screens/read_later_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NewsData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
              displaySmall: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
              displayLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              displayMedium:
                  TextStyle(fontSize: 23, color: Colors.black, wordSpacing: 7)),
        ),
        home: const FrontPage(),
        routes: {
          NewsDetailScreen.routeName: (context) => NewsDetailScreen(),
          ReadLaterScreen.routeName: (context) => ReadLaterScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     appBar: AppBar(
  //       title: Text('News'),
  //     ),
  //     body: ,
    // );
    // body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       const Text(
    //         'You have pushed the button this many times:',
    //       ),
    //       Text(
    //         '$_counter',
    //         style: Theme.of(context).textTheme.headline4,
    //       ),
    //     ],
    //   ),
    // ),
    // floatingActionButton: FloatingActionButton(
    //   onPressed: (() {
    //     Provider.of<NewsData>(context, listen: false).fetchNews();
    //     _incrementCounter;
    //   }),
    //   tooltip: 'Increment',
    //   child: const Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
//   }
// }
