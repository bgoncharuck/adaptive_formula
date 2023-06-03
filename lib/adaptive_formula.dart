library adaptive_formula;

import 'package:flutter/material.dart';

const _defaultFigmaScreenSize = Size(375, 812);

void adaptiveFormulaInitFromBuildContext({
  required BuildContext context,
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) =>
    adaptiveFormulaInitFromSize(
      deviceScreenSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      figmaScreenSize: figmaScreenSize,
    );

void adaptiveFormulaInitFromSize({
  required Size deviceScreenSize,
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) {
  _figmaScreenWidth = figmaScreenSize.width;
  _figmaScreenHeight = figmaScreenSize.height;
  _deviceScreenWidth = deviceScreenSize.width;
  _deviceScreenHeight = deviceScreenSize.height;
}

late double _deviceScreenWidth;
late double _deviceScreenHeight;
late double _figmaScreenWidth;
late double _figmaScreenHeight;

double adaptiveHeight(double elementHeight, {double? screenHeight}) =>
    (screenHeight ?? _deviceScreenHeight) * elementHeight / _figmaScreenHeight;
double adaptiveWidth(double elementWidth, {double? screenWidth}) =>
    (screenWidth ?? _deviceScreenWidth) * elementWidth / _figmaScreenWidth;
double adaptiveFontSize(TextStyle textStyle, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) * textStyle.fontSize! / _figmaScreenWidth).floor().toDouble();
double adaptiveFontSizeRaw(double fontSize, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) * fontSize / _figmaScreenWidth).floor().toDouble();
TextStyle adaptiveTextStyle(TextStyle textStyle, {double? screenWidth}) => textStyle.copyWith(
    fontSize: ((screenWidth ?? _deviceScreenWidth) * textStyle.fontSize! / _figmaScreenWidth).floor().toDouble());

EdgeInsetsGeometry adaptiveLTRB(
  double left,
  double top,
  double right,
  double bottom,
) =>
    EdgeInsets.fromLTRB(
      adaptiveWidth(left),
      adaptiveHeight(top),
      adaptiveWidth(right),
      adaptiveHeight(bottom),
    );

EdgeInsetsGeometry adaptiveInset({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveWidth(left),
      top == null ? 0 : adaptiveHeight(top),
      right == null ? 0 : adaptiveWidth(right),
      bottom == null ? 0 : adaptiveHeight(bottom),
    );

EdgeInsetsGeometry adaptiveSymmetricInset({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveWidth(horizontal),
      vertical: vertical == null ? 0 : adaptiveHeight(vertical),
    );

Size adaptiveSize(double width, double height) => Size(adaptiveWidth(width), adaptiveHeight(height));

Size adaptiveSquare(double size) => Size(adaptiveWidth(size), adaptiveWidth(size));

Size adaptiveSquareHeight(double size) => Size(adaptiveHeight(size), adaptiveHeight(size));

class AdaptiveSize extends StatelessWidget {
  const AdaptiveSize({
    this.width,
    this.height,
    this.child,
    Key? key,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? null : adaptiveWidth(width!),
      height: height == null ? null : adaptiveHeight(height!),
      child: child,
    );
  }
}

class AdaptiveWidth extends StatelessWidget {
  const AdaptiveWidth({
    required this.width,
    this.child,
    Key? key,
  }) : super(key: key);
  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveWidth(width),
      child: child,
    );
  }
}

class AdaptiveHeight extends StatelessWidget {
  const AdaptiveHeight({
    required this.height,
    this.child,
    Key? key,
  }) : super(key: key);
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adaptiveHeight(height),
      child: child,
    );
  }
}

class AdaptiveSquare extends StatelessWidget {
  const AdaptiveSquare({
    required this.size,
    this.child,
    Key? key,
  }) : super(key: key);
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveWidth(size),
      height: adaptiveWidth(size),
      child: child,
    );
  }
}

class AdaptiveSquareHeight extends StatelessWidget {
  const AdaptiveSquareHeight({
    required this.size,
    this.child,
    Key? key,
  }) : super(key: key);
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveHeight(size),
      height: adaptiveHeight(size),
      child: child,
    );
  }
}

class AdaptiveSizeColored extends StatelessWidget {
  const AdaptiveSizeColored({
    this.width,
    this.height,
    required this.color,
    this.child,
    Key? key,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: width == null ? null : adaptiveWidth(width!),
        height: height == null ? null : adaptiveHeight(height!),
        child: child,
      ),
    );
  }
}

class AdaptiveWidthColored extends StatelessWidget {
  const AdaptiveWidthColored({
    required this.width,
    required this.color,
    this.child,
    Key? key,
  }) : super(key: key);
  final double width;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: adaptiveWidth(width),
        child: child,
      ),
    );
  }
}

class AdaptiveHeightColored extends StatelessWidget {
  const AdaptiveHeightColored({
    required this.height,
    required this.color,
    this.child,
    Key? key,
  }) : super(key: key);
  final double height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: adaptiveHeight(height),
        child: child,
      ),
    );
  }
}

class AdaptiveSquareColored extends StatelessWidget {
  const AdaptiveSquareColored({
    required this.size,
    required this.color,
    this.child,
    Key? key,
  }) : super(key: key);
  final double size;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: adaptiveWidth(size),
        height: adaptiveWidth(size),
        child: child,
      ),
    );
  }
}

class AdaptiveSizeDecorated extends StatelessWidget {
  const AdaptiveSizeDecorated({
    this.width,
    this.height,
    required this.decoration,
    this.child,
    Key? key,
  }) : super(key: key);
  final double? width;
  final double? height;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: width == null ? null : adaptiveWidth(width!),
        height: height == null ? null : adaptiveHeight(height!),
        child: child,
      ),
    );
  }
}

class AdaptiveWidthDecorated extends StatelessWidget {
  const AdaptiveWidthDecorated({
    required this.width,
    required this.decoration,
    this.child,
    Key? key,
  }) : super(key: key);
  final double width;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: adaptiveWidth(width),
        child: child,
      ),
    );
  }
}

class AdaptiveHeightDecorated extends StatelessWidget {
  const AdaptiveHeightDecorated({
    required this.height,
    required this.decoration,
    this.child,
    Key? key,
  }) : super(key: key);
  final double height;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        height: adaptiveHeight(height),
        child: child,
      ),
    );
  }
}

class AdaptiveSquareDecorated extends StatelessWidget {
  const AdaptiveSquareDecorated({
    required this.size,
    required this.decoration,
    this.child,
    Key? key,
  }) : super(key: key);
  final double size;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: adaptiveWidth(size),
        height: adaptiveWidth(size),
        child: child,
      ),
    );
  }
}

class Position extends StatelessWidget {
  const Position({
    this.align = Alignment.topCenter,
    this.inset = EdgeInsets.zero,
    this.child,
    Key? key,
  }) : super(key: key);
  final AlignmentGeometry align;
  final EdgeInsetsGeometry inset;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Padding(
        padding: inset,
        child: child,
      ),
    );
  }
}

class AdaptiveList extends StatelessWidget {
  const AdaptiveList({
    Key? key,
    required this.elementHeight,
    required this.elementSpacing,
    required this.children,
  }) : super(key: key);
  final double elementHeight;
  final double elementSpacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final count = children.length;
    final positionedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      positionedChildren.add(
        _AdaptiveListPos(
          index: i,
          elementHeight: elementHeight,
          elementSpacing: elementSpacing,
          child: children[i],
        ),
      );
    }

    return SizedBox(
      height: adaptiveHeight(elementHeight) * count + elementSpacing * (count - 1),
      child: Stack(
        children: positionedChildren,
      ),
    );
  }
}

class _AdaptiveListPos extends StatelessWidget {
  const _AdaptiveListPos({
    required this.index,
    required this.elementHeight,
    required this.elementSpacing,
    this.child,
  });
  final int index;
  final double elementHeight;
  final double elementSpacing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
          padding: EdgeInsets.only(
            top: (adaptiveHeight(elementHeight) + adaptiveHeight(elementSpacing)) * index,
          ),
          child: child),
    );
  }
}

const voidWidget = _VoidWidget();

class _VoidWidget extends Widget {
  const _VoidWidget();

  @override
  Element createElement() => _VoidWidgetElement(this);
}

class _VoidWidgetElement extends Element {
  _VoidWidgetElement(_VoidWidget widget) : super(widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {
    super.performRebuild();
  }
}
