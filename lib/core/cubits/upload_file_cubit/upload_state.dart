part of 'upload_cubit.dart';

sealed class UploadFileState extends Equatable {
  final String uniqueName;

  const UploadFileState(this.uniqueName);

  @override
  List<Object> get props => [uniqueName];
}

class UploadInitial extends UploadFileState {
  const UploadInitial(super.uniqueName);
}

class UploadPendingLoading extends UploadFileState {
  const UploadPendingLoading({required String uniqueName}) : super(uniqueName);
}

class UploadLoading extends UploadFileState {
  final num progress;
  final num total;
  final num recived;

  const UploadLoading(
      {required this.total,
      required this.recived,
      required this.progress,
      required String uniqueName})
      : super(uniqueName);

  @override
  List<Object> get props => [progress, uniqueName];
}

class UploadFailure extends UploadFileState {
  final String errMessage;

  const UploadFailure({required this.errMessage, required String uniqueId})
      : super(uniqueId);

  @override
  List<Object> get props => [errMessage, uniqueName];
}

class UploadSuccess extends UploadFileState {
  final Filee file;
  const UploadSuccess(this.file, {required String uniqueName})
      : super(uniqueName);

  @override
  List<Object> get props => [uniqueName];
}
