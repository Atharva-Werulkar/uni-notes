import 'package:flutter/material.dart';

class ShimmerLoader extends StatefulWidget {
  final Widget child;
  final LinearGradient gradient;
  final double width;
  final double height;

  const ShimmerLoader({
    Key? key,
    required this.child,
    required this.gradient,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return ShaderMask(
          shader: widget.gradient.createShader(
            Rect.fromLTWH(
              0,
              _animationController.value * widget.height,
              widget.width,
              widget.height,
            ),
          ),
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
