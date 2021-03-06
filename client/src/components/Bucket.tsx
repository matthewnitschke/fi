import React from 'react';
import { useSelector, useDispatch, shallowEqual } from 'react-redux';

import { useDrop } from 'react-dnd';

import { updateItem } from '../modules/items/items.actions';
import { selectItem } from '../modules/root/root.actions';

import { itemValueSelectorFactory } from '../modules/items/items.selectors';
import { assignedTransactionsSumSelectorFactory } from '../modules/transactions/transactions.selectors';

import TextInput from './util/TextInput';
import '../styles/bucket.scss';
import ProgressIndicator from './util/ProgressIndicator';
import { AppState } from '../redux/state';

export default function Bucket({ itemId }) {
  const dispatch = useDispatch();

  const item = useSelector(
    (state: AppState) => state.items[itemId],
    shallowEqual
  );

  const transactionSum = useSelector<AppState, number>(
    assignedTransactionsSumSelectorFactory(itemId),
    shallowEqual
  );

  const itemValueSum = useSelector<AppState, number>(
    itemValueSelectorFactory(itemId)
  );

  const [{ isOver }, drop] = useDrop({
    accept: 'transaction',
    drop: () => ({ itemId: itemId }),
    collect: (monitor) => ({
      isOver: monitor.isOver(),
      canDrop: monitor.canDrop(),
    }),
  });

  if (item == null) return null;

  return (
    <div
      ref={drop}
      className={`bucket ${isOver ? 'transaction-hovered' : ''}`}
      onClick={() => dispatch(selectItem(itemId))}
    >
      <div className="label">
        <TextInput
          value={item.label}
          placeholder="Label"
          onValueChange={(v) =>
            dispatch(updateItem(itemId, { ...item, label: v }))
          }
        />
      </div>
      <div className="max-amount">${itemValueSum}</div>

      <div className="amount-slider">
        <ProgressIndicator value={transactionSum} max={itemValueSum} />
      </div>
    </div>
  );
}
