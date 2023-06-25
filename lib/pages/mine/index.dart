/*
 * @Author: wufengliang 44823912@qq.com
 * @Date: 2023-06-05 09:43:19
 * @LastEditTime: 2023-06-05 09:43:50
 * @Description: 
 */
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('个人中心'),
    );
  }
}
