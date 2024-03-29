import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction.sg.g.dart';

abstract class Transaction implements Built<Transaction, TransactionBuilder> {
  String get id;
  
  double get amount;

  String? get merchant;

  String get name;

  DateTime get date;

  static Serializer<Transaction> get serializer => _$transactionSerializer;

  factory Transaction([void Function(TransactionBuilder) updates]) = _$Transaction;
  Transaction._();
}