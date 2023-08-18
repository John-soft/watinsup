import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });

  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      context,
      constrinats,
    ) {
      if (constrinats.maxWidth > 938) {
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}
