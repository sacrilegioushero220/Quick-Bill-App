import 'package:quick_bill/model/item_model.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  ItemLoaded({required this.items});

  @override
  String toString() => 'ItemLoaded(items: $items)';
}
