/*
 * @Author: wufengliang 44823912@qq.com
 * @Date: 2023-06-05 09:41:18
 * @LastEditTime: 2023-06-25 14:12:38
 * @Description:  测试页
 */
import 'package:flutter/material.dart';
import '../../components/step_bar.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider滑块'),
      ),
      body: SizedBox(
        width: size.width,
        height: 60,
        child: const CustomStepBar(
          initValue: 90,
          labelTop: 45,
          direction: FlexDirection.ROW,
        ),
      ),
    );
  }
}
