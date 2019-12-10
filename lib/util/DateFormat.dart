import 'package:intl/intl.dart';

String dateFormatted()
{
  var now=DateTime.now();
  var formatter=new DateFormat.MEd();
  String formatted=formatter.format(now);
  return formatted;
}