import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

const _uuidGenerator = Uuid();
String newUuid() => _uuidGenerator.v4(options: {'rng': UuidUtil.cryptoRNG}).toString();


// final oCcy = NumberFormat('#,##0.00', 'en_US');

extension CurrencyFormat on double {
  String formatCurrency([int decimalDigits = 0]) => NumberFormat.simpleCurrency(
    locale: 'en_US',
    decimalDigits: decimalDigits,
  ).format(this);
}