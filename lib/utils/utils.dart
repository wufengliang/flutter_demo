/*
 * @Author: wufengliang 44823912@qq.com
 * @Date: 2023-06-25 10:28:26
 * @LastEditTime: 2023-06-25 10:31:08
 * @Description: 
 */
import 'package:flutter/material.dart';

class Utils {
  // 计算大小
  static Size getTextSize(String text, {TextStyle? style}) {
    TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '',
    );
    painter.layout();
    return painter.size;
  }
}
