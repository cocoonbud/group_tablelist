import 'package:flutter/material.dart';

import 'group_tablelist_example.dart';
import 'sliver_group_tablelist_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    {
      return MaterialApp(
        title: 'Group TableList Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      );
    }
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Group List View Demo'),
        ),
        body: _makeBody());
  }

  Widget _makeBody() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          onPressed: () {
            // 跳转到一个新的页面
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const GroupTablelistExample();
            }));
          },
          child: const Text(
            "GroupTablelist",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1, // 设置下行高，否则字体下沉
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const SliverGroupTablelistExample();
            }));
          },
          child: const Text(
            "SliverGroupTablelist",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1, // 设置下行高，否则字体下沉
            ),
          ),
        ),
      ]),
    );
  }
}
