import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'listener/tap.dart';

class DateItemWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthStyle, dayStyle, dateStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  const DateItemWidget({
    required this.date,
    required this.monthStyle,
    required this.dayStyle,
    required this.dateStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                  new DateFormat("MMM", locale).format(date).toUpperCase(),
                  // Month
                  style: monthStyle),
              AutoSizeText(date.day.toString(), // Date
                  style: dateStyle),
              AutoSizeText(
                  new DateFormat("E", locale).format(date).toUpperCase(),
                  // WeekDay
                  style: dayStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
