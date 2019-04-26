import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String numberFormat2(Decimal d) => NumberFormat(",###.##").format(d);