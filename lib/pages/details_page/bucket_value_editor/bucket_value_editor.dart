import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/pages/details_page/bucket_value_editor/static_bucket_value_editor.dart';
import 'package:fi/pages/details_page/bucket_value_editor/table_bucket_value_editor.dart';
import 'package:flutter/material.dart';

class BucketValueEditor extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;
  const BucketValueEditor(
    this.bucket,
    this.bucketId, {
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = bucket.value;
    if (value is StaticBucketValue) {
      return StaticBucketValueEditor(
        bucketValue: value,
        bucketId: bucketId,
      );
    }

    if (value is TableBucketValue) {
      return TableBucketValueEditor(
        bucketValue: value,
        bucketId: bucketId,
      );
    }

    return const Text('Dynamically calculated');
  }
}