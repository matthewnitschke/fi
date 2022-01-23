import 'package:fi/models/app_state.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/widgets/utils/extendable_fab.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

class RootAddButton extends StatelessWidget {
  const RootAddButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic Function(dynamic)>(
      converter: (store) => store.dispatch,
      builder: (ctx, dispatch) {
        return ExpandableFab(
          distance: 70,
          children: [
            ActionButton(
              onPressed: () => dispatch(AddBucketGroupAction()),
              icon: const Icon(Icons.library_add),
            ),
            ActionButton(
              onPressed: () => dispatch(AddBucketAction()),
              icon: const Icon(Icons.add_box),
            ),
          ],
        );
      },
    );
    
  }
}