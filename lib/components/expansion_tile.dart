import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    Key key,
    @required this.title,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.initiallyExpanded: false,
    this.controller,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ExpansionController controller;

  @override
  AppExpansionTileState createState() => new AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeInAnimation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(duration: _kExpand, vsync: this);
    widget.controller.controller = _controller;
    _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.title,
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpansionController>.value(
      value: widget.controller,
      child: Consumer<ExpansionController>(
        builder: (_, state, __) => AnimatedBuilder(
          animation: _controller.view,
          builder: _buildChildren,
          child: state.isClosed ? null : new Column(children: widget.children),
        ),
      ),
    );
  }
}

class ExpansionController extends ChangeNotifier {
  bool _isExpanded = false;
  AnimationController controller;

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  bool get isClosed => !_isExpanded && controller.isDismissed;

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      _isExpanded = isExpanded;
      if (_isExpanded)
        controller.forward();
      else
        controller.reverse().then<void>((value) {
          notifyListeners();
        });
      notifyListeners();
    }
  }
}
