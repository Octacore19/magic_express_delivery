import 'package:intl/intl.dart';

String convertToNairaAndKobo(double value) {
  final _formatter = NumberFormat('\u20A6 #,##0.00');
  return _formatter.format(value);
}

String convertToNaira(double value) {
  final _formatter = NumberFormat('\u20A6#,##0');
  return _formatter.format(value);
}
