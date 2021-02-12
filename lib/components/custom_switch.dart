import 'dart:ui' show lerpDouble;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';

/* const double _kTrackWidth = 51.0;
const double _kTrackHeight = 31.0;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kTrackInnerStart = _kTrackHeight / 2.0;
const double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
const double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
const double _kSwitchWidth = 59.0;
const double _kSwitchHeight = 39.0; */

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.trackColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.switchColor,
    this.shadows,
    this.switchRadius,
    this.switchExtent,
    this.trackWidth,
    this.trackHeight,
    this.switchWidth,
    this.switchHeight,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color trackColor;
  final DragStartBehavior dragStartBehavior;
  final Color switchColor;
  final List<BoxShadow> shadows;
  final double switchRadius;
  final double switchExtent;
  final double trackWidth;
  final double trackHeight;
  final double switchWidth;
  final double switchHeight;

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with TickerProviderStateMixin {
  TapGestureRecognizer _tap;
  HorizontalDragGestureRecognizer _drag;

  AnimationController _positionController;
  CurvedAnimation position;

  AnimationController _reactionController;
  Animation<double> _reaction;

  bool get isInteractive => widget.onChanged != null;

  bool needsPositionAnimation = false;

  double _kTrackInnerLength;
  double _kTrackInnerStart;
  double _kTrackInnerEnd;

  @override
  void initState() {
    super.initState();

    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = widget.dragStartBehavior;

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );
    position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
    _reactionController = AnimationController(
      duration: _kReactionDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );

    _kTrackInnerStart = widget.trackHeight / 2;
    _kTrackInnerEnd = widget.trackWidth - _kTrackInnerStart;
    _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _drag.dragStartBehavior = widget.dragStartBehavior;

    if (needsPositionAnimation || oldWidget.value != widget.value)
      _resumePositionAnimation(isLinear: needsPositionAnimation);
  }

  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    position
      ..curve = isLinear ? null : Curves.ease
      ..reverseCurve = isLinear ? null : Curves.ease.flipped;
    if (widget.value)
      _positionController.forward();
    else
      _positionController.reverse();
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) needsPositionAnimation = false;
    _reactionController.forward();
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isInteractive) _reactionController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.forward();
      _emitVibration();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = null
        ..reverseCurve = null;
      final double delta = details.primaryDelta / _kTrackInnerLength;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _positionController.value -= delta;
          break;
        case TextDirection.ltr:
          _positionController.value += delta;
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (position.value >= 0.5 != widget.value) widget.onChanged(!widget.value);
    _reactionController.reverse();
  }

  void _emitVibration() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        HapticFeedback.lightImpact();
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) _resumePositionAnimation();
    return Opacity(
      opacity: widget.onChanged == null ? _kCupertinoSwitchDisabledOpacity : 1.0,
      child: _CupertinoSwitchRenderObjectWidget(
        value: widget.value,
        activeColor: CupertinoDynamicColor.resolve(
          widget.activeColor ?? CupertinoColors.systemGreen,
          context,
        ),
        trackColor: CupertinoDynamicColor.resolve(
            widget.trackColor ?? CupertinoColors.secondarySystemFill, context),
        onChanged: widget.onChanged,
        textDirection: Directionality.of(context),
        shadows: widget.shadows,
        switchColor: widget.switchColor,
        state: this,
        trackHeight: widget.trackHeight,
        trackWidth: widget.trackWidth,
        switchHeight: widget.switchHeight,
        switchWidth: widget.switchWidth,
        trackInnerEnd: _kTrackInnerEnd,
        trackInnerLength: _kTrackInnerLength,
        trackRadius: widget.trackHeight / 2,
        trackInnerStart: _kTrackInnerStart,
        switchExtent: widget.switchExtent,
        switchRadius: widget.switchRadius,
      ),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();

    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}

class _CupertinoSwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _CupertinoSwitchRenderObjectWidget({
    Key key,
    this.trackWidth,
    this.trackHeight,
    this.switchWidth,
    this.switchHeight,
    this.shadows,
    this.switchColor,
    this.value,
    this.activeColor,
    this.trackColor,
    this.onChanged,
    this.textDirection,
    this.state,
    this.switchRadius,
    this.switchExtent,
    this.trackRadius,
    this.trackInnerStart,
    this.trackInnerEnd,
    this.trackInnerLength,
  }) : super(key: key);

  final bool value;
  final Color activeColor;
  final Color trackColor;
  final ValueChanged<bool> onChanged;
  final _CustomSwitchState state;
  final TextDirection textDirection;
  final List<BoxShadow> shadows;
  final Color switchColor;
  final double switchRadius;
  final double switchExtent;
  final double trackRadius;
  final double trackInnerStart;
  final double trackInnerEnd;
  final double trackInnerLength;
  final double trackWidth;
  final double trackHeight;
  final double switchWidth;
  final double switchHeight;

  @override
  _RenderCupertinoSwitch createRenderObject(BuildContext context) {
    return _RenderCupertinoSwitch(
      value: value,
      activeColor: activeColor,
      trackColor: trackColor,
      onChanged: onChanged,
      textDirection: textDirection,
      shadows: shadows,
      switchColor: switchColor,
      state: state,
      trackHeight: trackHeight,
      switchHeight: switchHeight,
      switchWidth: switchWidth,
      trackWidth: trackWidth,
      switchExtent: switchExtent,
      switchRadius: switchRadius,
      trackInnerEnd: trackInnerEnd,
      trackInnerStart: trackInnerStart,
      trackInnerLength: trackInnerLength,
      trackRadius: trackRadius,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderCupertinoSwitch renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..onChanged = onChanged
      ..textDirection = textDirection;
  }
}

/* const double _kTrackWidth = 51.0;
const double _kTrackHeight = 31.0;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kTrackInnerStart = _kTrackHeight / 2.0;
const double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
const double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
const double _kSwitchWidth = 59.0;
const double _kSwitchHeight = 39.0; */
// Opacity of a disabled switch, as eye-balled from iOS Simulator on Mac.
const double _kCupertinoSwitchDisabledOpacity = 0.5;

const Duration _kReactionDuration = Duration(milliseconds: 300);
const Duration _kToggleDuration = Duration(milliseconds: 200);

class _RenderCupertinoSwitch extends RenderConstrainedBox {
  _RenderCupertinoSwitch({
    @required bool value,
    @required Color activeColor,
    @required Color trackColor,
    @required this.switchRadius,
    @required this.switchExtent,
    @required this.switchColor,
    @required this.shadows,
    @required this.trackRadius,
    @required this.trackInnerStart,
    @required this.trackInnerEnd,
    @required this.trackInnerLength,
    @required this.trackWidth,
    @required this.trackHeight,
    @required this.switchWidth,
    @required this.switchHeight,
    ValueChanged<bool> onChanged,
    @required TextDirection textDirection,
    @required _CustomSwitchState state,
  })  : assert(value != null),
        assert(activeColor != null),
        assert(state != null),
        _value = value,
        _activeColor = activeColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _textDirection = textDirection,
        _state = state,
        super(
            additionalConstraints:
                BoxConstraints.tightFor(width: switchWidth, height: switchHeight)) {
    state.position.addListener(markNeedsPaint);
    state._reaction.addListener(markNeedsPaint);
  }
  final Color switchColor;
  final List<BoxShadow> shadows;
  final _CustomSwitchState _state;
  final double switchRadius;
  final double switchExtent;
  final double trackRadius;
  final double trackInnerStart;
  final double trackInnerEnd;
  final double trackInnerLength;
  final double trackWidth;
  final double trackHeight;
  final double switchWidth;
  final double switchHeight;

  bool get value => _value;
  bool _value;
  set value(bool value) {
    assert(value != null);
    if (value == _value) return;
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;
  set activeColor(Color value) {
    assert(value != null);
    if (value == _activeColor) return;
    _activeColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;
  set trackColor(Color value) {
    assert(value != null);
    if (value == _trackColor) return;
    _trackColor = value;
    markNeedsPaint();
  }

  ValueChanged<bool> get onChanged => _onChanged;
  ValueChanged<bool> _onChanged;
  set onChanged(ValueChanged<bool> value) {
    if (value == _onChanged) return;
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsPaint();
  }

  bool get isInteractive => onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isInteractive) config.onTap = _state._handleTap;

    config.isEnabled = isInteractive;
    config.isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final double currentValue = _state.position.value;
    final double currentReactionValue = _state._reaction.value;

    double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
        break;
      case TextDirection.ltr:
        visualPosition = currentValue;
        break;
    }

    final Paint paint = Paint()..color = Color.lerp(trackColor, activeColor, currentValue);

    final Rect trackRect = Rect.fromLTWH(
      offset.dx + (size.width - trackWidth) / 2.0,
      offset.dy + (size.height - trackHeight) / 2.0,
      trackWidth,
      trackHeight,
    );
    final RRect trackRRect = RRect.fromRectAndRadius(trackRect, Radius.circular(trackHeight / 2));
    canvas.drawRRect(trackRRect, paint);

    final double currentThumbExtension = switchExtent * currentReactionValue;
    final double thumbLeft = lerpDouble(
      trackRect.left + trackInnerStart - switchRadius,
      trackRect.left + trackInnerEnd - switchRadius - currentThumbExtension,
      visualPosition,
    );
    final double thumbRight = lerpDouble(
      trackRect.left + trackInnerStart + switchRadius + currentThumbExtension,
      trackRect.left + trackInnerEnd + switchRadius,
      visualPosition,
    );
    final double thumbCenterY = offset.dy + size.height / 2.0;
    final Rect thumbBounds = Rect.fromLTRB(
      thumbLeft,
      thumbCenterY - switchRadius,
      thumbRight,
      thumbCenterY + switchRadius,
    );

    context.pushClipRRect(needsCompositing, Offset.zero, thumbBounds, trackRRect,
        (PaintingContext innerContext, Offset offset) {
      ThumbPainter(shadows: shadows, color: switchColor, borderColor: switchColor.withOpacity(0.9))
          .paint(innerContext.canvas, thumbBounds);
    });
  }
}

class ThumbPainter {
  ThumbPainter({
    this.borderColor,
    this.color = CupertinoColors.white,
    this.shadows,
  }) : assert(shadows != null);

  final Color color;
  final Color borderColor;
  final List<BoxShadow> shadows;

  void paint(Canvas canvas, Rect rect) {
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.shortestSide / 2.0),
    );

    for (final BoxShadow shadow in shadows)
      canvas.drawRRect(rrect.shift(shadow.offset), shadow.toPaint());

    canvas.drawRRect(
      rrect.inflate(0.5),
      Paint()..color = borderColor,
    );
    canvas.drawRRect(rrect, Paint()..color = color);
  }
}
