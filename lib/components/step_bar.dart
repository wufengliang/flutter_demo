/*
 * @Author: wufengliang 44823912@qq.com
 * @Date: 2023-06-20 10:23:25
 * @LastEditTime: 2023-06-25 11:37:33
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_demo/utils/utils.dart';

enum FlexDirection {
  ROW,
  COLUMNS,
}

class CustomStepBar extends StatefulWidget {
  const CustomStepBar({
    super.key,
    this.showOperateIcon = true,
    this.leftIcon,
    this.rightIcon,
    this.onChange,
    this.initValue = 0.0,
    this.minValue = 0,
    this.maxValue = 100,
    this.wrapperMargin,
    this.wrapperPadding,
    this.direction = FlexDirection.ROW,
    this.showLabel = true,
    this.labelStyle = const TextStyle(
      fontSize: 14,
    ),
    this.defaultColor = const Color.fromRGBO(153, 153, 153, 1),
    this.thumpShapeSize = 10.0,
    required this.labelTop,
  });

  //  初始容器margin
  final EdgeInsets? wrapperMargin;

  //  初始容器padding
  final EdgeInsets? wrapperPadding;

  //  显示操作按钮
  final bool showOperateIcon;

  //  左侧操作按钮
  final Widget? leftIcon;

  //  右侧操作按钮
  final Widget? rightIcon;

  //  初始值
  final double initValue;

  //  最小值
  final double minValue;

  //  最大值
  final double maxValue;

  //  布局方向
  final FlexDirection direction;

  //  是否展示label标签
  final bool showLabel;

  //  label标签的样式
  final TextStyle? labelStyle;

  //  初始label的top值
  final double? labelTop;

  // 圆心大小
  final double? thumpShapeSize;

  //  默认颜色
  final Color? defaultColor;

  //  数值改变后的回调
  final Function(double)? onChange;

  @override
  State<CustomStepBar> createState() => _CustomStepBarState();
}

class _CustomStepBarState extends State<CustomStepBar> {
  final GlobalKey _sliderKey = GlobalKey();

  double initValue = 0;

  double leftValue = 0;

  double? boxWidth;

  int get _quarterTurns => widget.direction == FlexDirection.ROW ? 0 : 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: 此处延迟处理，fix获取容器宽度数值异常问题
      Future.delayed(const Duration(milliseconds: 100), () {
        setCurrentValue(widget.initValue);
      });
    });
  }

  //  渲染左侧操作按钮
  Widget renderLeftIcon() {
    return GestureDetector(
      onTap: () {
        if (initValue - 1 >= widget.minValue) {
          setCurrentValue(initValue - 1);
        }
      },
      child: Icon(
        Icons.remove,
        color: widget.defaultColor,
      ),
    );
  }

  //  渲染右侧操作按钮
  Widget renderRightIcon() {
    return GestureDetector(
      onTap: () {
        if (initValue + 1 <= widget.maxValue) {
          setCurrentValue(initValue + 1);
        }
      },
      child: Icon(
        Icons.add,
        color: widget.defaultColor,
      ),
    );
  }

  //  设置当前进度值
  void setCurrentValue(double value) {
    int number = value.floor();
    setState(() {
      initValue = double.parse('$number');
    });
    setPositionLeft();
  }

  //  设置left大小
  void setPositionLeft() {
    RenderBox renderbox =
        _sliderKey.currentContext!.findRenderObject() as RenderBox;
    boxWidth = renderbox.size.width;

    double _thumbSize = widget.thumpShapeSize!;

    double width = boxWidth != null ? boxWidth! - _thumbSize * 2 : 0;

    Size labelSize =
        Utils.getTextSize(initValue.toString(), style: widget.labelStyle);

    setState(() {
      leftValue = (initValue / widget.maxValue) * width +
          _thumbSize -
          labelSize.width / 2;
    });

    if (widget.onChange != null) {
      widget.onChange!(initValue);
    }
  }

  //  渲染中间步骤条
  Widget renderStepBar() {
    Widget child = Stack(
      clipBehavior: Clip.none,
      key: _sliderKey,
      children: [
        Container(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              overlayShape: SliderComponentShape.noThumb,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: widget.thumpShapeSize!,
              ),
            ),
            child: Slider(
              value: initValue,
              min: widget.minValue,
              max: widget.maxValue,
              onChanged: setCurrentValue,
            ),
          ),
        ),
        Positioned(
          left: leftValue,
          top: widget.labelTop,
          child: RotatedBox(
            quarterTurns: widget.direction == FlexDirection.ROW ? 0 : 3,
            child: Text(
              initValue.floor().toString(),
              style: widget.labelStyle != null
                  ? widget.labelStyle!
                      .merge(TextStyle(color: widget.defaultColor))
                  : TextStyle(color: widget.defaultColor),
            ),
          ),
        ),
      ],
    );

    return Expanded(
      flex: 1,
      child: RotatedBox(
        quarterTurns: widget.direction == FlexDirection.ROW ? 0 : 1,
        child: child,
      ),
    );
  }

  //  渲染子项容器
  List<Widget> renderWidgets() {
    List<Widget> children = [];

    children.add(renderStepBar());

    if (widget.showOperateIcon) {
      children
        ..insert(0, widget.leftIcon ?? renderLeftIcon())
        ..add(widget.rightIcon ?? renderRightIcon());
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.wrapperMargin,
      padding: widget.wrapperPadding,
      child: Flex(
        direction: widget.direction != FlexDirection.ROW
            ? Axis.vertical
            : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: renderWidgets(),
      ),
    );
  }
}
