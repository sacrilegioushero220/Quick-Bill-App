part of 'storage_cubit.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}

final class StorageLoading extends StorageState {}

final class StorageSaving extends StorageState {}

final class BusinessDetailsSaved extends StorageState {
  final BusinessDetails details;

  BusinessDetailsSaved({required this.details});
}

final class CustomerDetailsSaved extends StorageState {
  final Customer details;

  CustomerDetailsSaved({required this.details});
}

final class ItemAdded extends StorageState {
  final List<Item> item;

  ItemAdded({required this.item});
}

final class ItemRemoved extends StorageState {
  final List<Item> item;

  ItemRemoved({required this.item});
}

final class ItemLoaded extends StorageState {
  final List<Item> item;

  ItemLoaded({required this.item});
}

final class ItemListCleared extends StorageState {}

final class ItemCleared extends StorageState {}

final class StorageLoaded extends StorageState {}

final class StorageEmpty extends StorageState {}

final class StorageError extends StorageState {
  final String message;

  StorageError({required this.message});
}
