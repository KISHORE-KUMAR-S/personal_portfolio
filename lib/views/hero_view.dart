import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio/extension/screen_size_extension.dart';
import 'package:personal_portfolio/widgets/nav_wrapper_widget.dart';

class HeroView extends StatefulWidget {
  final ScrollController scrollController;

  const HeroView({super.key, required this.scrollController});

  @override
  State<HeroView> createState() => _HeroViewState();
}

class _HeroViewState extends State<HeroView> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavWrapperWidget(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              _backgroundGradient(context),
            ],
          );
        },
      ),
    ));
  }

  void _scrollListener() {
    if (widget.scrollController.offset >= 200 && _isScrolled == false) {
      setState(() => _isScrolled = true);
    } else if (widget.scrollController.offset <= 200 && _isScrolled == true) {
      setState(() => _isScrolled = false);
    }
  }

  Widget _backgroundGradient(BuildContext context) {
    return Positioned(
      top: context.isMobile ? -40 : 250,
      child: Opacity(
        opacity: 0.6,
        child: Entry.offset(
          yOffset: -500,
          delay: const Duration(seconds: 4),
          duration: const Duration(seconds: 3),
          child: Container(
            height: 900,
            width: MediaQuery.of(context).size.width + 30,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 0.8,
                stops: const [-2, -1],
                colors: [
                  Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
