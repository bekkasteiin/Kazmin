import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';

const String fName = 'lib/core/components/widgets/cupertino_date_time_selector.dart';

class KzmCupertinoDateTimeSelector extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onSelectDateTime;

  const KzmCupertinoDateTimeSelector({
    @required this.initialDateTime,
    @required this.onSelectDateTime,
  });

  @override
  _KzmCupertinoDateTimeSelectorState createState() => _KzmCupertinoDateTimeSelectorState();
}

class _KzmCupertinoDateTimeSelectorState extends State<KzmCupertinoDateTimeSelector> {
  bool _isDate = true;
  DateTime _selectedDate;
  DateTime _selectedTime;
  DateTime _selectedDateTime;

  @override
  void initState() {
    _selectedDate = DateUtils.dateOnly(widget.initialDateTime);
    _selectedTime = widget.initialDateTime;
    super.initState();
  }

  DateTime get selectedDateTime => _selectedDate.add(
        Duration(
          hours: _selectedTime.hour,
          minutes: _selectedTime.minute,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: Get.height / 4,
              child: CupertinoDatePicker(
                key: UniqueKey(),
                minimumYear: widget.initialDateTime.year - 100,
                maximumYear: widget.initialDateTime.year + 100,
                initialDateTime: (_selectedDateTime == null) ? widget.initialDateTime : _selectedDateTime,
                use24hFormat: !_isDate,
                mode: _isDate ? CupertinoDatePickerMode.date : CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime val) {
                  if (_isDate) {
                    _selectedDate = val;
                  } else {
                    _selectedTime = val;
                  }
                  _selectedDateTime = selectedDateTime;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Styles.appDoubleMargin),
              child: Padding(
                padding: (Platform.isIOS) ? EdgeInsets.only(bottom: Styles.appQuadMargin) : EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      child: _isDate ? KzmIcons.dateSelected : KzmIcons.date,
                      onTap: () {
                        setState(() {
                          _isDate = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: KzmIcons.done,
                      onTap: () {
                        widget.onSelectDateTime(selectedDateTime);
                        Get.back();
                      },
                    ),
                    GestureDetector(
                      child: !_isDate ? KzmIcons.timeSelected : KzmIcons.time,
                      onTap: () {
                        setState(() {
                          _isDate = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
            // Text('DT: $val'),
          ],
        ),
      ),
    );
  }
}
