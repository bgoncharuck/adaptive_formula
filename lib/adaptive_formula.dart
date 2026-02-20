library adaptive_formula;

import 'package:flutter/widgets.dart';

// init

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

void adaptiveFormulaInitFromWindow({
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) =>
    adaptiveFormulaInitFromSize(
      deviceScreenSize: Size(
        WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width,
        WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height,
      ),
      figmaScreenSize: figmaScreenSize,
    );

void adaptiveFormulaInitFromBinding({
  required WidgetsBinding binding,
  Size figmaScreenSize = _defaultFigmaScreenSize,
}) =>
    adaptiveFormulaInitFromSize(
      deviceScreenSize: Size(
        binding.platformDispatcher.views.first.physicalSize.width,
        binding.platformDispatcher.views.first.physicalSize.height,
      ),
      figmaScreenSize: figmaScreenSize,
    );

late double _deviceScreenWidth;
late double _deviceScreenHeight;
late double _figmaScreenWidth;
late double _figmaScreenHeight;

/// Default orientation

double adaptiveHeight(double elementHeight, {double? screenHeight}) =>
    (screenHeight ?? _deviceScreenHeight) * elementHeight / _figmaScreenHeight;
double adaptiveWidth(double elementWidth, {double? screenWidth}) =>
    (screenWidth ?? _deviceScreenWidth) * elementWidth / _figmaScreenWidth;
double adaptiveFontSize(TextStyle textStyle, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) *
            textStyle.fontSize! /
            _figmaScreenWidth)
        .floor()
        .toDouble();
double adaptiveFontSizeRaw(double fontSize, {double? screenWidth}) =>
    ((screenWidth ?? _deviceScreenWidth) * fontSize / _figmaScreenWidth)
        .floor()
        .toDouble();
TextStyle adaptiveTextStyle(TextStyle textStyle, {double? screenWidth}) =>
    textStyle.copyWith(
      fontSize: ((screenWidth ?? _deviceScreenWidth) *
              textStyle.fontSize! /
              _figmaScreenWidth)
          .floor()
          .toDouble(),
    );

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

EdgeInsetsGeometry adaptiveInsetOnWidth({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveWidth(left),
      top == null ? 0 : adaptiveWidth(top),
      right == null ? 0 : adaptiveWidth(right),
      bottom == null ? 0 : adaptiveWidth(bottom),
    );

EdgeInsetsGeometry adaptiveInsetOnHeight({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveHeight(left),
      top == null ? 0 : adaptiveHeight(top),
      right == null ? 0 : adaptiveHeight(right),
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

EdgeInsetsGeometry adaptiveSymmetricInsetOnWidth({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveWidth(horizontal),
      vertical: vertical == null ? 0 : adaptiveWidth(vertical),
    );

EdgeInsetsGeometry adaptiveSymmetricInsetOnHeight({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveHeight(horizontal),
      vertical: vertical == null ? 0 : adaptiveHeight(vertical),
    );

Size adaptiveSize(double width, double height) =>
    Size(adaptiveWidth(width), adaptiveHeight(height));

Size adaptiveSquare(double size) =>
    Size(adaptiveWidth(size), adaptiveWidth(size));

Size adaptiveSquareHeight(double size) =>
    Size(adaptiveHeight(size), adaptiveHeight(size));

class AdaptiveSize extends StatelessWidget {
  const AdaptiveSize({
    this.width,
    this.height,
    this.child,
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    required this.color,
    this.width,
    this.height,
    this.child,
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    required this.decoration,
    this.width,
    this.height,
    this.child,
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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
    super.key,
  });
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

// Inversed Orientation

double adaptiveIHeight(double elementHeight, {double? screenWidth}) =>
    (screenWidth ?? _deviceScreenWidth) * elementHeight / _figmaScreenWidth;

double adaptiveIWidth(double elementWidth, {double? screenHeight}) =>
    (screenHeight ?? _deviceScreenHeight) * elementWidth / _figmaScreenHeight;

double adaptiveIFontSize(TextStyle textStyle, {double? screenHeight}) =>
    ((screenHeight ?? _deviceScreenHeight) *
            textStyle.fontSize! /
            _figmaScreenHeight)
        .floor()
        .toDouble();

double adaptiveIFontSizeRaw(double fontSize, {double? screenHeight}) =>
    ((screenHeight ?? _deviceScreenHeight) * fontSize / _figmaScreenHeight)
        .floor()
        .toDouble();

TextStyle adaptiveITextStyle(TextStyle textStyle, {double? screenHeight}) =>
    textStyle.copyWith(
      fontSize: ((screenHeight ?? _deviceScreenHeight) *
              textStyle.fontSize! /
              _figmaScreenHeight)
          .floor()
          .toDouble(),
    );

EdgeInsetsGeometry adaptiveILTRB(
  double left,
  double top,
  double right,
  double bottom,
) =>
    EdgeInsets.fromLTRB(
      adaptiveIWidth(left),
      adaptiveIHeight(top),
      adaptiveIWidth(right),
      adaptiveIHeight(bottom),
    );

EdgeInsetsGeometry adaptiveIInset({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveIWidth(left),
      top == null ? 0 : adaptiveIHeight(top),
      right == null ? 0 : adaptiveIWidth(right),
      bottom == null ? 0 : adaptiveIHeight(bottom),
    );

EdgeInsetsGeometry adaptiveIInsetOnWidth({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveIWidth(left),
      top == null ? 0 : adaptiveIWidth(top),
      right == null ? 0 : adaptiveIWidth(right),
      bottom == null ? 0 : adaptiveIWidth(bottom),
    );

EdgeInsetsGeometry adaptiveIInsetOnHeight({
  double? left,
  double? top,
  double? right,
  double? bottom,
}) =>
    EdgeInsets.fromLTRB(
      left == null ? 0 : adaptiveIHeight(left),
      top == null ? 0 : adaptiveIHeight(top),
      right == null ? 0 : adaptiveIHeight(right),
      bottom == null ? 0 : adaptiveIHeight(bottom),
    );

EdgeInsetsGeometry adaptiveISymmetricInset({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveIWidth(horizontal),
      vertical: vertical == null ? 0 : adaptiveIHeight(vertical),
    );

EdgeInsetsGeometry adaptiveISymmetricInsetOnWidth({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveIWidth(horizontal),
      vertical: vertical == null ? 0 : adaptiveIWidth(vertical),
    );

EdgeInsetsGeometry adaptiveISymmetricInsetOnHeight({
  double? horizontal,
  double? vertical,
}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal == null ? 0 : adaptiveIHeight(horizontal),
      vertical: vertical == null ? 0 : adaptiveIHeight(vertical),
    );

Size adaptiveISize(double width, double height) =>
    Size(adaptiveIWidth(width), adaptiveIHeight(height));

Size adaptiveISquare(double size) =>
    Size(adaptiveIWidth(size), adaptiveIWidth(size));

Size adaptiveISquareHeight(double size) =>
    Size(adaptiveIHeight(size), adaptiveIHeight(size));

class AdaptiveISize extends StatelessWidget {
  const AdaptiveISize({
    this.width,
    this.height,
    this.child,
    super.key,
  });
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? null : adaptiveIWidth(width!),
      height: height == null ? null : adaptiveIHeight(height!),
      child: child,
    );
  }
}

class AdaptiveIWidth extends StatelessWidget {
  const AdaptiveIWidth({
    required this.width,
    this.child,
    super.key,
  });
  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveIWidth(width),
      child: child,
    );
  }
}

class AdaptiveIHeight extends StatelessWidget {
  const AdaptiveIHeight({
    required this.height,
    this.child,
    super.key,
  });
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adaptiveIHeight(height),
      child: child,
    );
  }
}

class AdaptiveISquare extends StatelessWidget {
  const AdaptiveISquare({
    required this.size,
    this.child,
    super.key,
  });
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveIWidth(size),
      height: adaptiveIWidth(size),
      child: child,
    );
  }
}

class AdaptiveISquareHeight extends StatelessWidget {
  const AdaptiveISquareHeight({
    required this.size,
    this.child,
    super.key,
  });
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptiveIHeight(size),
      height: adaptiveIHeight(size),
      child: child,
    );
  }
}

class AdaptiveISizeColored extends StatelessWidget {
  const AdaptiveISizeColored({
    required this.color,
    this.width,
    this.height,
    this.child,
    super.key,
  });
  final double? width;
  final double? height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: width == null ? null : adaptiveIWidth(width!),
        height: height == null ? null : adaptiveIHeight(height!),
        child: child,
      ),
    );
  }
}

class AdaptiveIWidthColored extends StatelessWidget {
  const AdaptiveIWidthColored({
    required this.width,
    required this.color,
    this.child,
    super.key,
  });
  final double width;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: adaptiveIWidth(width),
        child: child,
      ),
    );
  }
}

class AdaptiveIHeightColored extends StatelessWidget {
  const AdaptiveIHeightColored({
    required this.height,
    required this.color,
    this.child,
    super.key,
  });
  final double height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: adaptiveIHeight(height),
        child: child,
      ),
    );
  }
}

class AdaptiveISquareColored extends StatelessWidget {
  const AdaptiveISquareColored({
    required this.size,
    required this.color,
    this.child,
    super.key,
  });
  final double size;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        width: adaptiveIWidth(size),
        height: adaptiveIWidth(size),
        child: child,
      ),
    );
  }
}

class AdaptiveISizeDecorated extends StatelessWidget {
  const AdaptiveISizeDecorated({
    required this.decoration,
    this.width,
    this.height,
    this.child,
    super.key,
  });
  final double? width;
  final double? height;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: width == null ? null : adaptiveIWidth(width!),
        height: height == null ? null : adaptiveIHeight(height!),
        child: child,
      ),
    );
  }
}

class AdaptiveIWidthDecorated extends StatelessWidget {
  const AdaptiveIWidthDecorated({
    required this.width,
    required this.decoration,
    this.child,
    super.key,
  });
  final double width;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: adaptiveIWidth(width),
        child: child,
      ),
    );
  }
}

class AdaptiveIHeightDecorated extends StatelessWidget {
  const AdaptiveIHeightDecorated({
    required this.height,
    required this.decoration,
    this.child,
    super.key,
  });
  final double height;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        height: adaptiveIHeight(height),
        child: child,
      ),
    );
  }
}

class AdaptiveISquareDecorated extends StatelessWidget {
  const AdaptiveISquareDecorated({
    required this.size,
    required this.decoration,
    this.child,
    super.key,
  });
  final double size;
  final BoxDecoration decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration,
      child: SizedBox(
        width: adaptiveIWidth(size),
        height: adaptiveIWidth(size),
        child: child,
      ),
    );
  }
}

// Pos and Void

class Position extends StatelessWidget {
  const Position({
    this.align = Alignment.bottomCenter,
    this.inset = EdgeInsets.zero,
    this.child,
    super.key,
  });
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
    required this.elementHeight,
    required this.elementSpacing,
    required this.children,
    super.key,
  });
  final double elementHeight;
  final double elementSpacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final count = children.length;
    final positionedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
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
      height:
          adaptiveHeight(elementHeight) * count + elementSpacing * (count - 1),
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
          top:
              (adaptiveHeight(elementHeight) + adaptiveHeight(elementSpacing)) *
                  index,
        ),
        child: child,
      ),
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
  _VoidWidgetElement(_VoidWidget super.widget);

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
