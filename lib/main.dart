/*
 * @Author: wufengliang 44823912@qq.com
 * @Date: 2023-04-20 10:48:05
 * @LastEditTime: 2023-06-25 16:09:35
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/slider/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter 前端演示 Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> dataSource = [
    {
      'title': '滑动块',
      'url': '/slider',
      'component': (_) => SliderPage(),
    },
    {
      'title': "测试",
      'url': '/test',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: dataSource.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1, color: Colors.black38);
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: dataSource.elementAt(index)['component'],
                  ),
                );
              },
              child: Text(dataSource.elementAt(index)['title']!),
            ),
          );
        },
      ),
    );
  }
}
