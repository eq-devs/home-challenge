import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DgHome extends StatefulWidget {
  @override
  _DgHomeState createState() => _DgHomeState();

  final Widget? leading;

  final Widget title;

  final bool centerTitle;

  final List<Widget>? actions;

  final bool alwaysShowLeadingAndAction;

  final bool alwaysShowTitle;

  final Widget? drawer;

  final double headerExpandedHeight;

  final Widget headerWidget;

  final Widget? headerBottomBar;

  final Color? backgroundColor;

  final Color? appBarColor;

  final double curvedBodyRadius;

  final List<Widget> body;

  final bool fullyStretchable;

  final double stretchTriggerOffset;

  final double stretchMaxHeight;

  final Widget? floatingActionButton;

  final Widget? bottomSheet;

  final double? bottomNavigationBarHeight;

  final Widget? bottomNavigationBar;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final ScrollPhysics? physics;

  const DgHome(
      {Key? key,
      this.leading,
      required this.title,
      this.centerTitle = true,
      this.actions,
      this.alwaysShowLeadingAndAction = false,
      this.alwaysShowTitle = false,
      this.headerExpandedHeight = 0.35,
      required this.headerWidget,
      this.headerBottomBar,
      this.backgroundColor,
      this.appBarColor,
      this.curvedBodyRadius = 20,
      required this.body,
      this.drawer,
      this.fullyStretchable = false,
      this.stretchTriggerOffset = 200,
      // this.expandedBody,
      this.stretchMaxHeight = 0.9,
      this.bottomSheet,
      this.bottomNavigationBarHeight = kBottomNavigationBarHeight,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.physics})
      : assert(headerExpandedHeight > 0.0 &&
            headerExpandedHeight < stretchMaxHeight),
        assert(
          (stretchMaxHeight > headerExpandedHeight) && (stretchMaxHeight < .95),
        ),
        super(key: key);
}

class _DgHomeState extends State<DgHome> {
  final bool _isFullyCollapsed = false;

  var appbarH = AppBar().preferredSize.height;
  late ValueNotifier<bool> _event;

  @override
  void initState() {
    super.initState();
    _event = ValueNotifier(_isFullyCollapsed);
  }

  @override
  void dispose() {
    _event.dispose();

    super.dispose();
  }

  void setIsFullyCollapsed(bool b) {
    _event.value = b;
  }

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final double appBarHeight = appbarH + widget.curvedBodyRadius;
    final double expandedHeight = md.size.height * widget.headerExpandedHeight;
    final double bottomPadding =
        widget.bottomNavigationBar == null ? 0 : kBottomNavigationBarHeight;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        drawer: widget.drawer,
        extendBody: false,
        body: NotificationListener<ScrollNotification>(
            key: widget.key,
            onNotification: (notification) {
              var isFullyCollapsed = _event.value;
              if (notification.metrics.axis == Axis.vertical) {
                if (notification.metrics.extentBefore >
                    expandedHeight - appbarH - 40) {
                  if (!isFullyCollapsed) setIsFullyCollapsed(true);
                } else {
                  if (isFullyCollapsed) setIsFullyCollapsed(false);
                }
              }
              return false;
            },
            child: CustomScrollView(
              key: const ValueKey('CustomScrollView'),
              primary: true,
              shrinkWrap: true,
              physics: widget.physics ?? const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                ValueListenableBuilder<bool>(
                  valueListenable: _event,
                  builder: (context, fullyCollapsed, child) {
                    return SliverAppBar(
                        backgroundColor: !fullyCollapsed
                            ? widget.backgroundColor
                            : widget.appBarColor,
                        leading: widget.alwaysShowLeadingAndAction
                            ? widget.leading
                            : !fullyCollapsed
                                ? const SizedBox()
                                : widget.leading,
                        actions: widget.alwaysShowLeadingAndAction
                            ? widget.actions
                            : !fullyCollapsed
                                ? []
                                : widget.actions,
                        elevation: 0,
                        pinned: true,
                        stretch: true,
                        centerTitle: widget.centerTitle,
                        title: widget.alwaysShowTitle
                            ? widget.title
                            : AnimatedOpacity(
                                opacity: fullyCollapsed ? 1 : 0,
                                duration: const Duration(milliseconds: 100),
                                child: widget.title,
                              ),
                        collapsedHeight: appBarHeight,
                        expandedHeight: expandedHeight,
                        flexibleSpace: Stack(
                          children: [
                            FlexibleSpaceBar(
                                background: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(bottom: 30),
                                    child: fullyCollapsed
                                        ? const SizedBox()
                                        : widget.headerWidget
                                            .animate()
                                            .fadeIn())),
                            Positioned(
                                bottom: -1,
                                left: 0,
                                right: 0,
                                child: roundedCorner(context)),
                            Positioned(
                              bottom: 0 + widget.curvedBodyRadius,
                              child: AnimatedContainer(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                curve: Curves.easeInOutCirc,
                                duration: const Duration(milliseconds: 100),
                                height: fullyCollapsed ? 0 : kToolbarHeight,
                                width: md.size.width,
                                child: fullyCollapsed
                                    ? const SizedBox()
                                    : widget.headerBottomBar ?? Container(),
                              ),
                            )
                          ],
                        ),
                        stretchTriggerOffset: widget.stretchTriggerOffset,
                        onStretchTrigger: () async {
                          //refresh
                        });
                  },
                ),
                SliverList(
                  delegate:
                      SliverChildListDelegate(addRepaintBoundaries: true, [
                    SizedBox(
                      height: md.size.height -
                          appBarHeight -
                          kBottomNavigationBarHeight -
                          md.padding.top,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.body,
                      ),
                    )
                  ]),
                ),
              ],
            )),
        bottomSheet: widget.bottomSheet,
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator);
  }

  Container roundedCorner(BuildContext context) {
    return Container(
        height: widget.curvedBodyRadius,
        decoration: BoxDecoration(
            color: widget.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget.curvedBodyRadius))));
  }
}
