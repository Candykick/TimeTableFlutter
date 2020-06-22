import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'all_day.dart';
import 'content/timetable_content.dart';
import 'controller.dart';
import 'event.dart';
import 'theme.dart';

typedef EventBuilder<E extends Event> = Widget Function(E event);
typedef AllDayEventBuilder<E extends Event> = Widget Function(
  BuildContext context,
  E event,
  AllDayEventLayoutInfo info,
);

const double hourColumnWidth = 65;

class Timetable<E extends Event> extends StatelessWidget {
  const Timetable({
    Key key,
    @required this.controller,
    @required this.eventBuilder,
    @required this.headerDate,
    this.allDayEventBuilder,
    this.theme,
  })  : assert(controller != null),
        assert(eventBuilder != null),
        assert(headerDate != null),
        super(key: key);

  final DateTime headerDate;

  final TimetableController<E> controller;
  final EventBuilder<E> eventBuilder;

  /// Optional [Widget] builder function for all-day event shown in the header.
  ///
  /// If not set, [eventBuilder] will be used instead.
  final AllDayEventBuilder<E> allDayEventBuilder;

  final TimetableThemeData theme;

  @override
  Widget build(BuildContext context) {
    Widget child = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 9.0, top: 4.0),
          child: Text(
            DateFormat.y().format(headerDate)+"년",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black45),
          )
        ),
        centerTitle: true,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(DateFormat.M().format(headerDate)+"월 "+DateFormat.d().format(headerDate)+"일",
                  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black)),
              Text("("+DateFormat.E('ko_KR').format(headerDate)+')',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.black)),
            ])
        /*title: Container(
            //width: double.infinity,
            height: 40,
            //child: Padding(
            //  padding: const EdgeInsets.all(3.0),
              //child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //children: [
                  //Expanded(flex: 1, child: Container()),
                  child: Center(child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(DateFormat.M().format(headerDate)+"월 "+DateFormat.d().format(headerDate)+"일",
                            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.black)),
                        Text("("+DateFormat.E('ko_KR').format(headerDate)+')',
                            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black)),
                      ])),
                  //Expanded(flex: 1, child: Container()),
                //],
              //),
            //)
        )*/
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TimetableContent<E>(
              controller: controller,
              eventBuilder: eventBuilder,
            ),
          ),
        ],
      ),
    );

    if (theme != null) {
      child = TimetableTheme(data: theme, child: child);
    }

    return child;
  }
}
