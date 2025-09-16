import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String get fullDate => DateFormat("MM/dd/yyyy\nhh a").format(this);
}
