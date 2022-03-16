<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
Flutter Horizontal Date  Picker Library that provides a calendar as a horizontal scolling with center selection 

<p>
 <img src="https://github.com/SaNu-hIT/Flutter-Horizontal-Calendar/blob/main/Screenshot_1647429334.png"/>
</p>


## How To Use


Use this package as a library

```
dependencies:
     horizontalcalender: ^0.0.2
```


Import the following package in your dart file

```dart
import 'package:horizontalcalender/horizontalcalender.dart';
```

## Usage

This version is breaking backwards compatibility

Use the `HorizontalCalendar` Widget

```dart
  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController itemController =
        FixedExtentScrollController();
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: HorizontalCalendar(DateTime.now(),
            width: MediaQuery.of(context).size.width*.25,
            height: 120,
            selectionColor: Colors.red,
            itemController: itemController));
  }
```

##### Constructor:

```dart
  HorizontalCalendar(
    this.startDate, {
    Key? key,
    this.width = 40,
    this.height = 80,
    this.controller,
    this.monthTextStyle,
    this.dayTextStyle,
    this.dateTextStyle,
    this.selectedTextColor,
    this.selectionColor,
    this.deactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
    this.selectedDayStyle,
    this.selectedDateStyle,
    required this.itemController,
  });
```
