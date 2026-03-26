import 'package:flutter/material.dart';

/// Staggers section entrance animations on initial page load.
class SectionReveal extends StatefulWidget {
  /// Creates a reveal wrapper.
  const SectionReveal({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<SectionReveal> createState() => _SectionRevealState();
}

class _SectionRevealState extends State<SectionReveal> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(_delay, _show);
  }

  Duration get _delay => Duration(milliseconds: 120 * widget.index);

  void _show() {
    if (!mounted) {
      return;
    }

    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      opacity: _visible ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        offset: _visible ? Offset.zero : const Offset(0, 0.08),
        child: widget.child,
      ),
    );
  }
}
