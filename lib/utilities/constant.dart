import 'package:intl/intl.dart';

class Constant{

  static String getDateTime(int date){
  DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(date);
  return DateFormat("dd MMM yyyy, hh:mm a").format(dateTime);
  }

  static double defaultPadding=20;
}