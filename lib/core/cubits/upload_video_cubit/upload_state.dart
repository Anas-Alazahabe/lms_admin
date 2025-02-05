part of 'upload_cubit.dart';

sealed class UploadState extends Equatable {
  final String uniqueName;

  const UploadState(this.uniqueName);

  @override
  List<Object> get props => [uniqueName];
}

class UploadInitial extends UploadState {
  const UploadInitial(super.uniqueName);
}

class UploadPendingLoading extends UploadState {
  const UploadPendingLoading({required String uniqueName}) : super(uniqueName);
}

class UploadLoading extends UploadState {
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

class UploadFailure extends UploadState {
  final String errMessage;

  const UploadFailure({required this.errMessage, required String uniqueId})
      : super(uniqueId);

  @override
  List<Object> get props => [errMessage, uniqueName];
}

class UploadSuccess extends UploadState {
  final Video video;
  const UploadSuccess(this.video, {required String uniqueName})
      : super(uniqueName);

  @override
  List<Object> get props => [uniqueName];
}
