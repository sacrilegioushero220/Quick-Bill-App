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

final class StorageLoaded extends StorageState {}

final class StorageEmpty extends StorageState {}

final class StorageError extends StorageState {
  final String message;

  StorageError({required this.message});
}
