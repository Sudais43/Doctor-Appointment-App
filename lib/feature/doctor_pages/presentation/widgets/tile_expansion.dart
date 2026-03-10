import 'package:flutter/material.dart';

class TileExpansion extends StatefulWidget {
  final Widget child;
  final double expandedHeight;
  final double colapsedHeight;

  const TileExpansion({
    super.key,
    required this.child,
    this.colapsedHeight = 131,
    this.expandedHeight = 200,
  });

  @override
  State<TileExpansion> createState() => _TileExpansionState();
}

class _TileExpansionState extends State<TileExpansion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: widget.colapsedHeight,
      end: widget.expandedHeight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void handleLongPress() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: handleLongPress,
      onTap: _isExpanded ? handleLongPress : null,
      child: AnimatedBuilder(
        animation: _heightAnimation,
        child: widget.child,
        builder: (context, child) {
          return SizedBox(
            height: _heightAnimation.value,
            width: double.infinity,
            child: child,
          );
        },
      ),
    );
  }
}
