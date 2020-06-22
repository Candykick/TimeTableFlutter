import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart' hide Offset;
import 'package:intl/intl.dart';

import 'all_day.dart';
import 'event.dart';
import 'package:testformoney/util/customDateTimeFormat.dart';

/// A basic implementation of [Event] to get you started.
///
/// See also:
/// - [BasicEventWidget], which can display instances of [BasicEvent].
class BasicEvent extends Event {
  const BasicEvent({
    @required Object id,
    @required this.title,
    @required this.studio,
    @required LocalDateTime start,
    @required LocalDateTime end,
  })  : assert(title != null),
        super(id: id, start: start, end: end);

  /// A title for the user, used e.g. by [BasicEventWidget].
  final String title, studio;

  @override
  bool operator ==(dynamic other) =>
      super == other && title == other.title; // && color == other.color

  @override
  int get hashCode => hashList([super.hashCode, title]); //color
}

/// A simple [Widget] for displaying a [BasicEvent].
class BasicEventWidget extends StatelessWidget {
  const BasicEventWidget(
    this.event, {
    Key key,
    this.onTap,
  })  : assert(event != null),
        super(key: key);

  /// The [BasicEvent] to be displayed.
  final BasicEvent event;

  /// An optional [VoidCallback] that will be invoked when the user taps this
  /// widget.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.theme.scaffoldBackgroundColor,
          width: 0.75,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      color: Colors.red[700],
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(4, 2, 4, 0),
          child: DefaultTextStyle(
            style: context.textTheme.bodyText2.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('・'+event.title),
                  Text('・'+event.studio),
                  Text('・'+customDateTimeFormat(origin: event.start.toString('HH:mm'), end: event.end.toString('HH:mm')).returnDateTimeFormat()),
                ])
          ),
        ),
      ),
    );
  }
}

/// A simple [Widget] for displaying a [BasicEvent] as an all-day event.
class BasicAllDayEventWidget extends StatelessWidget {
  const BasicAllDayEventWidget(
    this.event, {
    Key key,
    @required this.info,
    this.borderRadius = 4,
    this.onTap,
  })  : assert(event != null),
        assert(info != null),
        assert(borderRadius != null),
        super(key: key);

  /// The [BasicEvent] to be displayed.
  final BasicEvent event;
  final AllDayEventLayoutInfo info;
  final double borderRadius;

  /// An optional [VoidCallback] that will be invoked when the user taps this
  /// widget.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: CustomPaint(
        painter: AllDayEventBackgroundPainter(
          info: info,
          color: Colors.red[700],
          borderRadius: borderRadius,
        ),
        child: Material(
          shape: AllDayEventBorder(
            info: info,
            side: BorderSide.none,
            borderRadius: borderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 2, 0, 2),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: context.textTheme.bodyText2.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
          child: Text(event.title, maxLines: 1),
        ),
      ),
    );
  }
}
