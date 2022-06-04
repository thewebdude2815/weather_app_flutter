import 'package:intl/intl.dart';

getCurrentDate() {
  var date = new DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  var totalDate = DateFormat().add_yMMMMd().format(dateParse);
  return totalDate;
}
