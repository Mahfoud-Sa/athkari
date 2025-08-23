
import 'package:flutter/material.dart';

class AnimatedDots extends StatefulWidget {
  final bool white;
  
  const AnimatedDots({super.key, this.white = true});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    // Create staggered animations for each dot
    _animations = List.generate(3, (index) {
      return Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2, // Stagger the start of each animation
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color dotColor = widget.white ? Colors.white : const Color(0xff3a3a3a);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAnimatedDot(0, dotColor),
        const SizedBox(width: 8),
        _buildAnimatedDot(1, dotColor),
        const SizedBox(width: 8),
        _buildAnimatedDot(2, dotColor),
      ],
    );
  }

  Widget _buildAnimatedDot(int index, Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + _animations[index].value * 0.5, // Scale from 0.5 to 1.0
          child: Opacity(
            opacity: 0.5 + _animations[index].value * 0.5, // Fade from 0.5 to 1.0
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}