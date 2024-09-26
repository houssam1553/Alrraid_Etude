/* import 'package:flutter/material.dart';

class AdvancedSwitch extends StatefulWidget {
  const AdvancedSwitch({
    Key? key,
    required this.value,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(const Radius.circular(15)),
    this.width = 50.0,
    this.height = 30.0,
    required this.onChanged,
  })  : assert(value != null),
        super(key: key);

  /// Determines current state.
  final bool value;

  /// Determines background color for the active state.
  final Color activeColor;

  /// Determines background color for the inactive state.
  final Color inactiveColor;

  /// Determines border radius.
  final BorderRadius borderRadius;

  /// Determines width.
  final double width;

  /// Determines height.
  final double height;

  /// Called on interaction.
  final ValueChanged<bool> onChanged;

  @override
  _AdvancedSwitchState createState() => _AdvancedSwitchState();
}

class _AdvancedSwitchState extends State<AdvancedSwitch> with SingleTickerProviderStateMixin {
  final _duration = Duration(milliseconds: 250);
  AnimationController _animationController;
  Animation<Color> _colorAnimation;/*  */
  
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      value: widget.value ? 1.0 : 0.0,
    );
    
   /*  _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
    ).animate(_animationController);
 */
    super.initState();
  }
  
  @override
  void didUpdateWidget(AdvancedSwitch oldWidget) {
    if (oldWidget.value == widget.value) {
      return super.didUpdateWidget(oldWidget);
    }

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged != null ? widget.onChanged(!widget.value) : null,
      child: Opacity(
        opacity: widget.onChanged != null ? 1.0 : 0.5,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            return Container(
              width: widget.width,
              height: widget.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: _colorAnimation.value,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
} */