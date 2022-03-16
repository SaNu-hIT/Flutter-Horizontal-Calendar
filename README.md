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

Import the following package in your dart file

```dart
import 'package:horizontalcalender/horizontalcalender.dart';
```

## Usage

This version is breaking backwards compatibility

Use the `DatePicker` Widget

```dart
Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      HorizontalCalendar(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.black,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          // New date selected
          setState(() {
            _selectedValue = date;
          });
        },
      ),
    ],
)
```

##### Constructor:

```dart
HorizontalCalendar(
    this.startDate, {
    Key key,
    this.width,
    this.height,
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
    this.daysCount,
    this.onDateChange,
    this.locale = "en_US",
}) : super(key: key);
```
