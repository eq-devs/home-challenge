import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListviewWidget extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final ScrollController? controller;
  const ListviewWidget({
    Key? key,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(8),
    required this.children,
    this.physics = const ClampingScrollPhysics(),
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: shrinkWrap,
      addRepaintBoundaries: true,
      key: const Key('ListView'),
      padding: padding,
      physics: physics,
      keyboardDismissBehavior: keyboardDismissBehavior,
      controller: controller,
      children: children,
    );
  }
}

class ListviewBuilderWidget extends StatelessWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final IndexedWidgetBuilder itemBuilder;
  final int? Function(Key)? findChildIndexCallback;
  final int? itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  const ListviewBuilderWidget(
      {super.key,
      this.scrollDirection = Axis.vertical,
      this.controller,
      this.reverse = false,
      this.primary,
      this.physics = const ClampingScrollPhysics(),
      this.shrinkWrap = false,
      this.padding,
      this.itemExtent,
      this.prototypeItem,
      required this.itemBuilder,
      this.findChildIndexCallback,
      this.itemCount,
      this.addAutomaticKeepAlives = false,
      this.addRepaintBoundaries = false,
      this.addSemanticIndexes = false,
      this.cacheExtent,
      this.semanticChildCount,
      this.dragStartBehavior = DragStartBehavior.start,
      this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      this.restorationId,
      this.clipBehavior = Clip.hardEdge});

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const Center(child: Text('Empty 🗒'));
    }
    return ListView.builder(
      key: const Key('ListView.builder'),
      scrollDirection: scrollDirection,
      itemBuilder: itemBuilder,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addAutomaticKeepAlives,
      addSemanticIndexes: addAutomaticKeepAlives,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemCount: itemCount,
      itemExtent: cacheExtent,
      primary: primary,
      padding: padding,
      physics: physics,
      prototypeItem: prototypeItem,
      restorationId: restorationId,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
    );
  }
}
