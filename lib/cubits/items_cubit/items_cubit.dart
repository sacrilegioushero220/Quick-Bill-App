import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/model/models.dart';

class ItemCubit extends Cubit<List<Item>> {
  ItemCubit() : super([]);

  void addItem(Item item) {
    final updatedItems = List<Item>.from(state)..add(item);
    emit(updatedItems);
  }

  void removeItem(Item item) {
    final updatedItems = List<Item>.from(state)..remove(item);
    emit(updatedItems);
  }

  void clearItems() {
    emit([]);
  }
}
