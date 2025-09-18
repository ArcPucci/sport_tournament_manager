import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String get fullDate => DateFormat("MM/dd/yyyy\nhh a").format(this);
  String get fullDate2 => DateFormat("MM/dd/yyyy hh a").format(this);
  String get fullDate3 => DateFormat("MM/dd/yyyy,\nhh a").format(this);
}
