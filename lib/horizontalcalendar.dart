library horizontalcalendar;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontalcalender/date_item_widget.dart';

import 'extra/color.dart';
import 'extra/style.dart';
import 'listener/tap.dart';

class HorizontalCalendar extends StatefulWidget {
  final DateTime startDate;

  final double width;

  final double height;

  final DatePickerController? controller;

  final Color selectedTextColor;

  final Color selectionColor;

  final Color deactivatedColor;

  final TextStyle monthTextStyle;

  final TextStyle dayTextStyle;

  final TextStyle selectedDayStyle;

  final TextStyle selectedDateStyle;

  final TextStyle dateTextStyle;

  final DateTime?  initialSelectedDate;

  final List<DateTime>? inactiveDates;

  final List<DateTime>? activeDates;

  final DateChangeListener? onDateChange;

  final int daysCount;

  final String locale;

  final FixedExtentScrollController itemController;

  HorizontalCalendar(
    this.startDate, {
    Key? key,
    this.width = 40,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
    this.selectedDayStyle = defaultSelectedTextStyle,
    this.selectedDateStyle = defaultSelectedTextStyle,
    required this.itemController,
  });

  @override
  State<StatefulWidget> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  ScrollController _controller = ScrollController();
  DateTime? _currentDate;

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;
  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;
  var itemSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: [
          Container(
            height: widget.height,
            child: RotatedBox(
                quarterTurns: -1,
                child: ListWheelScrollView(
                  diameterRatio: 10,
                  // useMagnifier: true,
                  offAxisFraction: 0,
                  onSelectedItemChanged: (x) {
                    setState(() {
                      itemSelected = x;
                      print("selected");
                      print(x);

                      DateTime _date = widget.startDate.add(Duration(days: x));
                      DateTime date =
                          new DateTime(_date.year, _date.month, _date.day);
                      if (widget.onDateChange != null) {
                        widget.onDateChange!(date, x);
                      }
                    });
                  },
                  children: List.generate(
                      widget.daysCount,
                      (x) => RotatedBox(
                          quarterTurns: 1,
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              child: StreamBuilder<Object>(
                                  stream: null,
                                  builder: (context, snapshot) {
                                    DateTime date;
                                    DateTime _date =
                                        widget.startDate.add(Duration(days: x));
                                    date = new DateTime(
                                        _date.year, _date.month, _date.day);
                                    bool isDeactivated = false;
                                    // check if this date needs to be deactivated for only DeactivatedDates
                                    if (widget.inactiveDates != null) {
                                      for (DateTime inactiveDate
                                          in widget.inactiveDates!) {
                                        if (_compareDate(date, inactiveDate)) {
                                          isDeactivated = true;
                                          break;
                                        }
                                      }
                                    }
                                    // check if this date needs to be deactivated for only ActivatedDates
                                    if (widget.activeDates != null) {
                                      isDeactivated = true;
                                      for (DateTime activateDate
                                          in widget.activeDates!) {
                                        // Compare the date if it is in the
                                        if (_compareDate(date, activateDate)) {
                                          isDeactivated = false;
                                          break;
                                        }
                                      }
                                    }

                                    // Check if this date is the one that is currently selected
                                    // bool isSelected =
                                    // _currentDate != null ? _compareDate(date, _currentDate!) : false;
                                    // Check if this date is the one that is currently selected
                                    bool isSelected = itemSelected == x;
                                    // Return the Date Widget
                                    return DateItemWidget(
                                      date: date,
                                      monthStyle: isDeactivated
                                          ? deactivatedDayStyle
                                          : isSelected
                                              ? widget.selectedDayStyle
                                              : widget.dayTextStyle,
                                      dateStyle: isDeactivated
                                          ? deactivatedDateStyle
                                          : isSelected
                                              ? widget.selectedDateStyle
                                              : widget.dateTextStyle,
                                      dayStyle: isDeactivated
                                          ? deactivatedDayStyle
                                          : isSelected
                                              ? widget.selectedDayStyle
                                              : widget.dayTextStyle,
                                      width: widget.width,
                                      locale: widget.locale,
                                      selectionColor: isSelected
                                          ? widget.selectionColor
                                          : Colors.white,
                                      onDateSelected: (selectedDate) {
                                        // Don't notify listener if date is deactivated
                                        if (isDeactivated) return;

                                        // A date is selected
                                        // if (widget.onDateChange != null) {
                                        //   widget.onDateChange!(selectedDate);
                                        // }
                                        // if (isSelected) {
                                        //   widget.onDateChange!(selectedDate);
                                        // }

                                        setState(() {
                                          _currentDate = selectedDate;
                                        });
                                      },
                                    );
                                  })))),
                  itemExtent: widget.width,
                )),
          ),
        ],
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _HorizontalCalendarState? _datePickerState;

  void setDatePickerState(_HorizontalCalendarState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as a parameter
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = new DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
