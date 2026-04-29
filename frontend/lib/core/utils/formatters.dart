import 'package:intl/intl.dart';

abstract final class PriceFormatter {
  static final _fmt = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  static final _fmtDecimal =
      NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  static String format(num amount) => _fmt.format(amount);
  static String formatDecimal(num amount) => _fmtDecimal.format(amount);
  static String perNight(num amount) => '${_fmt.format(amount)} night';
  static String total(num amount, int nights) =>
      '${_fmt.format(amount)} x $nights nights = ${_fmt.format(amount * nights)}';
}

abstract final class DateFmt {
  static final _md = DateFormat.MMMd();
  static final _mdy = DateFormat.yMMMd();

  static String monthDay(DateTime d) => _md.format(d);
  static String monthDayYear(DateTime d) => _mdy.format(d);
  static String range(DateTime start, DateTime end) =>
      '${_md.format(start)} – ${_md.format(end)}';
  static int nightsBetween(DateTime start, DateTime end) =>
      end.difference(start).inDays;
}
