import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_group.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';

part 'serializers.sg.g.dart';

@SerializersFor([
  AppState,
  BuiltMap,
  BuiltList,
  BucketGroup,
  StaticBucketValue,
  TableBucketValue,
  TableBucketValueEntry,
  ExtraBucketValue,
  Bucket,
  Transaction,
  Borrow,
])

Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();