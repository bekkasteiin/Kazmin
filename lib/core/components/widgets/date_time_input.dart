import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kzm/core/components/widgets/cupertino_date_time_selector.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/components/widgets/hint_text.dart';
import 'package:kzm/core/components/widgets/input_container.dart';
import 'package:kzm/core/components/widgets/text.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const String fName = 'lib/core/components/widgets/combo_input.dart';

class KzmDateTimeInput extends StatelessWidget {
  final String caption;
  final bool isRequired;
  final String initialDateTime;
  final DateFormat formatDateTime;
  final void Function(DateTime) onChanged;
  final bool isActive;
  final bool isLoading;

  const KzmDateTimeInput({
    @required this.caption,
    @required this.onChanged,
    @required this.initialDateTime,
    @required this.formatDateTime,
    @required this.isLoading,
    this.isRequired = false,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    // final bool _isNotNull = initialDateTime != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KzmFieldCaption(caption: caption, isRequired: isRequired),
        KzmInputContainer(
          isLoading: isLoading,
          isActive: isActive,
          child: isLoading
              ? null
              : ValueBuilder<DateTime>(
                  builder: (DateTime val, Function(DateTime) update) {
                    return InkWell(
                      onTap: isActive
                          ? () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) => KzmCupertinoDateTimeSelector(
                                  initialDateTime:
                                      (initialDateTime ?? '').isNotEmpty ? (formatDateTime ?? dateFormatFullRest).parse(initialDateTime) : DateTime.now(),
                                  onSelectDateTime: onChanged,
                                ),
                              );
                            }
                          : null,
                      child: Padding(
                        padding: EdgeInsets.only(left: Styles.appMiddleMargin, right: Styles.appMiddleMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            if ((initialDateTime ?? '').isNotEmpty) KzmText(text: initialDateTime) else KzmHintText(hint: S.current.setDateAndTime),
                            if ((initialDateTime ?? '').isNotEmpty) KzmIcons.dateSelected else KzmIcons.date,
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
