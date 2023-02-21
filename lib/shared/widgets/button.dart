import 'package:flutter/material.dart';
import 'package:weather_app/shared/styling/colors.dart';

class Button extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final bool hasBorder;
  final double borderWidth;
  final Color borderColor;
  final void Function() onTap;
  const Button(
      {super.key,
      this.width = 40,
      this.height = 40,
      this.color = AppColors.grey,
      this.hasBorder = false,
      this.borderColor = const Color(0xFF000000),
      this.borderWidth = 1,
      required this.child,
      required this.onTap});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    lowerBound: 0,
    duration: const Duration(milliseconds: 100),
    reverseDuration: const Duration(milliseconds: 100),
    vsync: this,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

  late final Animation<double> animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _controller.forward();
        await Future.delayed(_controller.duration! * 2, () => widget.onTap());
      },
      child: AnimatedBuilder(
          animation: animation,
          child: Center(child: widget.child),
          builder: (context, Widget? child) {
            return Transform.scale(
              scale: 1 - (0.2 * animation.value),
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  border: widget.hasBorder
                      ? Border.all(
                          color: widget.borderColor, width: widget.borderWidth)
                      : null,
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: child,
              ),
            );
          }),
    );
  }
}
