import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bucket_value.sg.g.dart';

enum BucketValueType {
  static, table, extra
}

abstract class BucketValue {
  BucketValueType get type;
}

abstract class StaticBucketValue implements BucketValue, Built<StaticBucketValue, StaticBucketValueBuilder> {
  @override
  BucketValueType get type => BucketValueType.static;

  double get amount;

  bool get isIncome;

  static void _initializeBuilder(StaticBucketValueBuilder b) => b
    ..amount = 0
    ..isIncome = false;

  static Serializer<StaticBucketValue> get serializer => _$staticBucketValueSerializer;

  StaticBucketValue._();
  factory StaticBucketValue([void Function(StaticBucketValueBuilder) updates]) = _$StaticBucketValue;
}

abstract class TableBucketValue implements BucketValue, Built<TableBucketValue, TableBucketValueBuilder> {
  @override
  BucketValueType get type => BucketValueType.table;

  BuiltList<TableBucketValueEntry> get entries;

  static Serializer<TableBucketValue> get serializer => _$tableBucketValueSerializer;

  TableBucketValue._();
  factory TableBucketValue([void Function(TableBucketValueBuilder) updates]) = _$TableBucketValue;
}

abstract class TableBucketValueEntry implements Built<TableBucketValueEntry, TableBucketValueEntryBuilder> {
  String? get label;

  double get amount;

  static void _initializeBuilder(TableBucketValueEntryBuilder b) => b
    ..amount = 0;

  static Serializer<TableBucketValueEntry> get serializer => _$tableBucketValueEntrySerializer;

  factory TableBucketValueEntry([void Function(TableBucketValueEntryBuilder) updates]) = _$TableBucketValueEntry;
  TableBucketValueEntry._();
}

abstract class ExtraBucketValue implements BucketValue, Built<ExtraBucketValue, ExtraBucketValueBuilder> {
  @override
  BucketValueType get type => BucketValueType.extra;

  static void _initializeBuilder(ExtraBucketValueBuilder b) => b;

  static Serializer<ExtraBucketValue> get serializer => _$extraBucketValueSerializer;

  ExtraBucketValue._();
  factory ExtraBucketValue([void Function(ExtraBucketValueBuilder) updates]) = _$ExtraBucketValue;
}