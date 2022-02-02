
import 'package:built_collection/built_collection.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/pages/details_page/bucket_value_editor/bucket_value_editor.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/utils.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatefulWidget {
  final Bucket bucket;
  final String bucketId;

  const DetailsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  static const _inputPadding = 15.0;

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {

  final _labelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _labelController.text = widget.bucket.label ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: DetailsTab._inputPadding),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(
                labelText: 'Label',
              ),
              onChanged: (newLabel) => dispatch(SetItemLabelAction(widget.bucketId, newLabel))
            ),
            const SizedBox(height: DetailsTab._inputPadding),
            DropdownButtonFormField(
              value: widget.bucket.value.type,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
              items: BucketValueType.values
                .map((v) => DropdownMenuItem(
                  value: v, 
                  child: Text(v.toString().split('.')[1].capitalize()),
                ))
                .toList(),
              onChanged: (val) {
                BucketValue newVal;

                switch (val) {
                  case BucketValueType.static:
                    newVal = StaticBucketValue();
                    break;
                  case BucketValueType.table:
                    newVal = TableBucketValue();
                    break;
                  case BucketValueType.extra:
                    newVal = ExtraBucketValue();
                    break;
                  default:
                    throw Exception('Unkown bucket value type $val');
                }

                dispatch(SetBucketValueAction(widget.bucketId, newVal));
              },
            ),
            const SizedBox(height: DetailsTab._inputPadding),
            BucketValueEditor(widget.bucket, widget.bucketId),
          ],
        )
      );
    });
  }
}